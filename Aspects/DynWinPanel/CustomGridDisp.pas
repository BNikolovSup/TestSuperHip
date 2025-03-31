unit CustomGridDisp;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Grids, system.Types,
  Winapi.Messages, Winapi.Windows, System.Variants,
  Vcl.Graphics, Vcl.Menus, Vcl.Forms, Vcl.StdCtrls, Vcl.Mask,
  System.UITypes;

type
  TCustomGridDisp = class(TCustomGrid)
  private
    FAnchor: TGridCoord;
    FBorderStyle: TBorderStyle;
    FCanEditModify: Boolean;
    FColCount: Longint;
    FCurrent: TGridCoord;
    FDefaultColWidth: Integer;
    FDefaultRowHeight: Integer;
    FDrawingStyle: TGridDrawingStyle;
    FFixedCols: Integer;
    FFixedRows: Integer;
    FFixedColor: TColor;
    FGradientEndColor: TColor;
    FGradientStartColor: TColor;
    FGridLineWidth: Integer;
    FOptions: TGridOptions;
    FPanPoint: TPoint;
    FRowCount: Longint;
    FScrollBars: System.UITypes.TScrollStyle;
    FTopLeft: TGridCoord;
    FSizingIndex: Longint;
    FSizingPos, FSizingOfs: Integer;
    FMoveIndex, FMovePos: Longint;
    FHitTest: TPoint;
    FInplaceEdit: TInplaceEdit;
    FInplaceCol, FInplaceRow: Longint;
    FColOffset: Integer;
    procedure GridRectToScreenRect(GridRect: TGridRect;
      var ScreenRect: TRect; IncludeLine: Boolean);
    function GetSelection: TGridRect;
  protected
    procedure DrawCell(ACol, ARow: Longint; ARect: TRect;
      AState: TGridDrawState); override;
    procedure Paint; override;
    function IsActiveControl: Boolean;
  public
    constructor Create(AOwner: TComponent); override;

    property Canvas;
    property Col;
    property ColWidths;
    property DrawingStyle;
    property EditorMode;
    property GridHeight;
    property GridWidth;
    property LeftCol;
    property Selection;
    property Row;
    property RowHeights;
    property TabStops;
    property TopRow;
    property ColCount;
  published
    property Align;
  end;

procedure Register;

implementation
uses
  System.Math, Vcl.Themes, System.RTLConsts, Vcl.Consts, Vcl.GraphUtil;
type
  PIntArray = ^TIntArray;
  TIntArray = array[0..MaxCustomExtents] of Integer;

procedure Register;
begin
  RegisterComponents('biser', [TCustomGridDisp]);
end;

function PointInGridRect(Col, Row: Longint; const Rect: TGridRect): Boolean;
begin
  Result := (Col >= Rect.Left) and (Col <= Rect.Right) and (Row >= Rect.Top)
    and (Row <= Rect.Bottom);
end;

function StackAlloc(Size: Integer): Pointer;
begin
  GetMem(Result, Size);
end;

procedure StackFree(P: Pointer);
begin
  FreeMem(P);
end;

procedure FillDWord(var Dest; Count, Value: Integer);
var
  I: Integer;
  P: PInteger;
begin
  P := PInteger(@Dest);
  for I := 0 to Count - 1 do
  begin
    P^ := Value;
    Inc(P);
  end;
end;

function GridRect(Coord1, Coord2: TGridCoord): TGridRect;
begin
  with Result do
  begin
    Left := Coord2.X;
    if Coord1.X < Coord2.X then Left := Coord1.X;
    Right := Coord1.X;
    if Coord1.X < Coord2.X then Right := Coord2.X;
    Top := Coord2.Y;
    if Coord1.Y < Coord2.Y then Top := Coord1.Y;
    Bottom := Coord1.Y;
    if Coord1.Y < Coord2.Y then Bottom := Coord2.Y;
  end;
end;

{ TCustomGridDisp }

constructor TCustomGridDisp.Create(AOwner: TComponent);
begin
  inherited;
  //RowCount := 2000;
  //ColCount := 20;
end;

procedure TCustomGridDisp.DrawCell(ACol, ARow: Integer; ARect: TRect; AState: TGridDrawState);
var
  Hold: Integer;
begin
  ARect.Left := ClientWidth - ARect.Left;
  ARect.Right := ClientWidth - ARect.Right;
  Hold := ARect.Left;
  ARect.Left := ARect.Right;
  ARect.Right := Hold;
end;

function TCustomGridDisp.GetSelection: TGridRect;
begin
  Result := GridRect(FCurrent, FAnchor);
end;

procedure TCustomGridDisp.GridRectToScreenRect(GridRect: TGridRect; var ScreenRect: TRect; IncludeLine: Boolean);
function LinePos(const AxisInfo: TGridAxisDrawInfo; Line: Integer): Integer;
  var
    Start, I: Longint;
  begin
    with AxisInfo do
    begin
      Result := 0;
      if Line < FixedCellCount then
        Start := 0
      else
      begin
        if Line >= FirstGridCell then
          Result := FixedBoundary;
        Start := FirstGridCell;
      end;
      for I := Start to Line - 1 do
      begin
        Inc(Result, AxisInfo.GetExtent(I) + EffectiveLineWidth);
        if Result > GridExtent then
        begin
          Result := 0;
          Exit;
        end;
      end;
    end;
  end;

  function CalcAxis(const AxisInfo: TGridAxisDrawInfo;
    GridRectMin, GridRectMax: Integer;
    var ScreenRectMin, ScreenRectMax: Integer): Boolean;
  begin
    Result := False;
    with AxisInfo do
    begin
      if (GridRectMin >= FixedCellCount) and (GridRectMin < FirstGridCell) then
        if GridRectMax < FirstGridCell then
        begin
          ScreenRect := Rect(0, 0, 0, 0); { erase partial results}
          Exit;
        end
        else
          GridRectMin := FirstGridCell;
      if GridRectMax > LastFullVisibleCell then
      begin
        GridRectMax := LastFullVisibleCell;
        if GridRectMax < GridCellCount - 1 then Inc(GridRectMax);
        if LinePos(AxisInfo, GridRectMax) = 0 then
          Dec(GridRectMax);
      end;

      ScreenRectMin := LinePos(AxisInfo, GridRectMin);
      ScreenRectMax := LinePos(AxisInfo, GridRectMax);
      if ScreenRectMax = 0 then
        ScreenRectMax := ScreenRectMin + AxisInfo.GetExtent(GridRectMin)
      else
        Inc(ScreenRectMax, AxisInfo.GetExtent(GridRectMax));
      if ScreenRectMax > GridExtent then
        ScreenRectMax := GridExtent;
      if IncludeLine then Inc(ScreenRectMax, EffectiveLineWidth);
    end;
    Result := True;
  end;

var
  DrawInfo: TGridDrawInfo;
  Hold: Integer;
begin
  ScreenRect := Rect(0, 0, 0, 0);
  if (GridRect.Left > GridRect.Right) or (GridRect.Top > GridRect.Bottom) then
    Exit;
  CalcDrawInfo(DrawInfo);
  with DrawInfo do
  begin
    if GridRect.Left > Horz.LastFullVisibleCell + 1 then Exit;
    if GridRect.Top > Vert.LastFullVisibleCell + 1 then Exit;

    if CalcAxis(Horz, GridRect.Left, GridRect.Right, ScreenRect.Left,
      ScreenRect.Right) then
    begin
      CalcAxis(Vert, GridRect.Top, GridRect.Bottom, ScreenRect.Top,
        ScreenRect.Bottom);
    end;
  end;
  if UseRightToLeftAlignment and (Canvas.CanvasOrientation = coLeftToRight) then
  begin
    Hold := ScreenRect.Left;
    ScreenRect.Left := ClientWidth - ScreenRect.Right;
    ScreenRect.Right := ClientWidth - Hold;
  end;
end;

function TCustomGridDisp.IsActiveControl: Boolean;
var
  H: Hwnd;
  ParentForm: TCustomForm;
begin
  Result := False;
  ParentForm := GetParentForm(Self);
  if Assigned(ParentForm) then
    Result := (ParentForm.ActiveControl = Self) and (ParentForm = Screen.ActiveCustomForm)
  else
  begin
    H := GetFocus;
    while IsWindow(H) and not Result do
    begin
      if H = WindowHandle then
        Result := True
      else
        H := GetParent(H);
    end;
  end;
end;

procedure TCustomGridDisp.Paint;
var
  LStyle: TCustomStyleServices;
  LColor: TColor;
  LineColor: TColor;
  LFixedColor: TColor;
  LFixedBorderColor: TColor;
  DrawInfo: TGridDrawInfo;
  Sel: TGridRect;
  UpdateRect: TRect;
  AFocRect, FocRect: TRect;
{$IF DEFINED(CLR)}
  PointsList: array of TPoint;
  StrokeList: array of DWORD;
  I: Integer;
{$ELSE}
  PointsList: PIntArray;
  StrokeList: PIntArray;
{$ENDIF}
  MaxStroke: Integer;
  FrameFlags1, FrameFlags2: DWORD;

  procedure DrawLines(DoHorz, DoVert: Boolean; Col, Row: Longint;
    const CellBounds: array of Integer; OnColor, OffColor: TColor);

  { Cellbounds is 4 integers: StartX, StartY, StopX, StopY
    Horizontal lines:  MajorIndex = 0
    Vertical lines:    MajorIndex = 1 }

  const
    FlatPenStyle = PS_Geometric or PS_Solid or PS_EndCap_Flat or PS_Join_Miter;

    procedure DrawAxisLines(const AxisInfo: TGridAxisDrawInfo;
      Cell, MajorIndex: Integer; UseOnColor: Boolean);
    var
      Line: Integer;
      LogBrush: TLOGBRUSH;
      Index: Integer;
      Points: PIntArray;
      StopMajor, StartMinor, StopMinor, StopIndex: Integer;
      LineIncr: Integer;
    begin
      Exit;
      with Canvas, AxisInfo do
      begin
        if EffectiveLineWidth <> 0 then
        begin
          Pen.Width := GridLineWidth;
          if UseOnColor then
            Pen.Color := OnColor
          else
            Pen.Color := OffColor;
          if Pen.Width > 1 then
          begin
            LogBrush.lbStyle := BS_Solid;
            LogBrush.lbColor := Pen.Color;
            LogBrush.lbHatch := 0;
            Pen.Handle := ExtCreatePen(FlatPenStyle, Pen.Width, LogBrush, 0, nil);
          end;
          Points := PointsList;
          Line := CellBounds[MajorIndex] + (EffectiveLineWidth shr 1) +
            AxisInfo.GetExtent(Cell);
          //!!! ??? Line needs to be incremented for RightToLeftAlignment ???
          if UseRightToLeftAlignment and (MajorIndex = 0) then Inc(Line);
          StartMinor := CellBounds[MajorIndex xor 1];
          StopMinor := CellBounds[2 + (MajorIndex xor 1)];
          if UseRightToLeftAlignment then Inc(StopMinor);
          StopMajor := CellBounds[2 + MajorIndex] + EffectiveLineWidth;
          StopIndex := MaxStroke * 4;
          Index := 0;
          repeat

            Points^[Index + MajorIndex] := Line;         { MoveTo }
            Points^[Index + (MajorIndex xor 1)] := StartMinor;
            Inc(Index, 2);
            Points^[Index + MajorIndex] := Line;         { LineTo }
            Points^[Index + (MajorIndex xor 1)] := StopMinor;
            Inc(Index, 2);
            // Skip hidden columns/rows.  We don't have stroke slots for them
            // A column/row with an extent of -EffectiveLineWidth is hidden
            repeat
              Inc(Cell);
              LineIncr := AxisInfo.GetExtent(Cell) + EffectiveLineWidth;
            until (LineIncr > 0) or (Cell > LastFullVisibleCell);
            Inc(Line, LineIncr);
          until (Line > StopMajor) or (Cell > LastFullVisibleCell) or (Index > StopIndex);

           { 2 integers per point, 2 points per line -> Index div 4 }
          PolyPolyLine(Canvas.Handle, Points^, StrokeList^, Index shr 2);
        end;
      end;
    end;

  begin
    if (CellBounds[0] = CellBounds[2]) or (CellBounds[1] = CellBounds[3]) then
      Exit;
    if not DoHorz then
    begin
      DrawAxisLines(DrawInfo.Vert, Row, 1, DoHorz);
      DrawAxisLines(DrawInfo.Horz, Col, 0, DoVert);
    end
    else
    begin
      DrawAxisLines(DrawInfo.Horz, Col, 0, DoVert);
      DrawAxisLines(DrawInfo.Vert, Row, 1, DoHorz);
    end;
  end;

  procedure DrawCells(ACol, ARow: Longint; StartX, StartY, StopX, StopY: Integer;
    AColor: TColor; IncludeDrawState: TGridDrawState);
  var
    CurCol, CurRow: Longint;
    AWhere, Where, TempRect: TRect;
    DrawState: TGridDrawState;
    Focused: Boolean;
  begin
    CurRow := ARow;
    Where.Top := StartY;
    while (Where.Top < StopY) and (CurRow < RowCount) do
    begin
      CurCol := ACol;
      Where.Left := StartX;
      Where.Bottom := Where.Top + RowHeights[CurRow];
      while (Where.Left < StopX) and (CurCol < ColCount) do
      begin
        Where.Right := Where.Left + ColWidths[CurCol];
        if (Where.Right > Where.Left) and RectVisible(Canvas.Handle, Where) then
        begin
          DrawState := IncludeDrawState;
          if (CurCol = FHotTrackCell.Coord.X) and (CurRow = FHotTrackCell.Coord.Y) then
          begin
            if (goFixedHotTrack in Options) then
              Include(DrawState, gdHotTrack);
            if FHotTrackCell.Pressed then
              Include(DrawState, gdPressed);
          end;
          Focused := IsActiveControl;
          if Focused and (CurRow = Row) and (CurCol = Col)  then
          begin
            SetCaretPos(Where.Left, Where.Top);
            Include(DrawState, gdFocused);
          end;
          if PointInGridRect(CurCol, CurRow, Sel) then
            Include(DrawState, gdSelected);
          if not (gdFocused in DrawState) or not (goEditing in Options) or
            not EditorMode or (csDesigning in ComponentState) then
          begin
            if DefaultDrawing or (csDesigning in ComponentState) then
            begin
              Canvas.Font := Self.Font;
              //if (gdSelected in DrawState) and
//                 (not (gdFocused in DrawState) or
//                 ([goDrawFocusSelected, goRowSelect] * Options <> [])) then
//                DrawCellHighlight(Where, DrawState, CurCol, CurRow)
//              else
//                DrawCellBackground(Where, AColor, DrawState, CurCol, CurRow);
              Canvas.MoveTo(Where.Left, Where.Bottom);
              if (CurCol = 2) and (CurRow = 3) then
              begin
                Canvas.MoveTo(Where.Right, Where.Bottom);
              end
              else
              begin
                Canvas.LineTo(Where.Right, Where.Bottom);
              end;
              Canvas.LineTo(Where.Right, Where.top);
              if (CurCol = 2) and (CurRow = 4) then
              begin
                Canvas.MoveTo(Where.left, Where.top);
              end
              else
              begin
                Canvas.LineTo(Where.left, Where.top);
              end;
              Canvas.LineTo(Where.left, Where.Bottom);
            end;
            AWhere := Where;
            if (gdPressed in DrawState) then
            begin
              Inc(AWhere.Top);
              Inc(AWhere.Left);
            end;
            //DrawCell(CurCol, CurRow, AWhere, DrawState);
            if DefaultDrawing and (gdFixed in DrawState) and Ctl3D and
              ((FrameFlags1 or FrameFlags2) <> 0) and
              (FInternalDrawingStyle = gdsClassic) and not (gdPressed in DrawState) then
            begin
              TempRect := Where;
              if (FrameFlags1 and BF_RIGHT) = 0 then
                Inc(TempRect.Right, DrawInfo.Horz.EffectiveLineWidth)
              else if (FrameFlags1 and BF_BOTTOM) = 0 then
                Inc(TempRect.Bottom, DrawInfo.Vert.EffectiveLineWidth);
              if not TStyleManager.IsCustomStyleActive then
              begin
                //DrawEdge(Canvas.Handle, TempRect, BDR_RAISEDINNER, FrameFlags1);
                //DrawEdge(Canvas.Handle, TempRect, BDR_RAISEDINNER, FrameFlags2);
              end;
            end;

            if DefaultDrawing and not (csDesigning in ComponentState) and
               not (TStyleManager.IsCustomStyleActive and (goDrawFocusSelected in Options)) and
               (gdFocused in DrawState) and
               ([goEditing, goAlwaysShowEditor] * Options <> [goEditing, goAlwaysShowEditor]) and
               not (goRowSelect in Options) then
            begin
              TempRect := Where;
              if (FInternalDrawingStyle = gdsThemed) and (Win32MajorVersion >= 6) and
                 not TStyleManager.IsCustomStyleActive then
                InflateRect(TempRect, -1, -1);
              Canvas.Brush.Style := bsSolid;
              if TStyleManager.IsCustomStyleActive then
              begin
                if UseRightToLeftAlignment then
                  OffsetRect(TempRect, 1, 0);
                DrawStyleFocusRect(Canvas.Handle, TempRect)
              end
              else if not UseRightToLeftAlignment then
              begin
                AWhere := AWhere;
               //DrawFocusRect(Canvas.Handle, TempRect)
              end
              else
              begin
                AWhere := TempRect;
                AWhere.Left := TempRect.Right;
                AWhere.Right := TempRect.Left;
                //DrawFocusRect(Canvas.Handle, AWhere);
              end;
            end;
          end;
        end;
        Where.Left := Where.Right + DrawInfo.Horz.EffectiveLineWidth;
        Inc(CurCol);
      end;
      Where.Top := Where.Bottom + DrawInfo.Vert.EffectiveLineWidth;
      Inc(CurRow);
    end;
  end;

begin
  Canvas.Brush.Color := clSilver;
  Canvas.FillRect(BoundsRect);
  if UseRightToLeftAlignment then ChangeGridOrientation(True);

  FInternalColor := Color;
  LStyle := StyleServices;
  if (FInternalDrawingStyle = gdsThemed) then
  begin
    LStyle.GetElementColor(LStyle.GetElementDetails(tgCellNormal), ecBorderColor, LineColor);
    if seClient in StyleElements then
      LStyle.GetElementColor(LStyle.GetElementDetails(tgCellNormal), ecFillColor, FInternalColor);
    LStyle.GetElementColor(LStyle.GetElementDetails(tgFixedCellNormal), ecBorderColor, LFixedBorderColor);
    LStyle.GetElementColor(LStyle.GetElementDetails(tgFixedCellNormal), ecFillColor, LFixedColor);
  end
  else
  begin
    if FInternalDrawingStyle = gdsGradient then
    begin
      LineColor := $F0F0F0;
      LFixedColor := Color;
      LFixedBorderColor := GetShadowColor($F0F0F0, -45);

      if LStyle.Enabled then
      begin
        if LStyle.GetElementColor(LStyle.GetElementDetails(tgGradientCellNormal),
           ecBorderColor, LColor) and (LColor <> clNone) then
          LineColor := LColor;
        if LStyle.GetElementColor(LStyle.GetElementDetails(tgGradientCellNormal),
           ecFillColor, LColor) and (LColor <> clNone) then
          FInternalColor := LColor;
        if LStyle.GetElementColor(LStyle.GetElementDetails(tgGradientFixedCellNormal),
           ecBorderColor, LColor) and (LColor <> clNone) then
          LFixedBorderColor := LColor;
        if LStyle.GetElementColor(LStyle.GetElementDetails(tgGradientFixedCellNormal),
           ecFillColor, LColor) and (LColor <> clNone) then
          LFixedColor := LColor;
      end;
    end
    else
    begin
      LineColor := clSilver;
      LFixedColor := FixedColor;
      LFixedBorderColor := clBlack;

      if LStyle.Enabled then
      begin
        if LStyle.GetElementColor(LStyle.GetElementDetails(tgClassicCellNormal),
           ecBorderColor, LColor) and (LColor <> clNone) then
          LineColor := LColor;
        if LStyle.GetElementColor(LStyle.GetElementDetails(tgClassicCellNormal),
           ecFillColor, LColor) and (LColor <> clNone) then
          FInternalColor := LColor;
        if LStyle.GetElementColor(LStyle.GetElementDetails(tgClassicFixedCellNormal),
           ecBorderColor, LColor) and (LColor <> clNone) then
          LFixedBorderColor := LColor;
        if LStyle.GetElementColor(LStyle.GetElementDetails(tgClassicFixedCellNormal),
           ecFillColor, LColor) and (LColor <> clNone) then
          LFixedColor := LColor;
      end;
    end;
  end;

  UpdateRect := Canvas.ClipRect;
  CalcDrawInfo(DrawInfo);
  with DrawInfo do
  begin
    if (Horz.EffectiveLineWidth > 0) or (Vert.EffectiveLineWidth > 0) then
    begin
      { Draw the grid line in the four areas (fixed, fixed), (variable, fixed),
        (fixed, variable) and (variable, variable) }
      MaxStroke := Max(Horz.LastFullVisibleCell - LeftCol + FixedCols,
        Vert.LastFullVisibleCell - TopRow + FixedRows) + 3;
{$IF DEFINED(CLR)}
      SetLength(PointsList, MaxStroke * 2); // two points per stroke
      SetLength(StrokeList, MaxStroke);
      for I := 0 to MaxStroke - 1 do
        StrokeList[I] := 2;
{$ELSE}
      PointsList := StackAlloc(MaxStroke * sizeof(TPoint) * 2);
      StrokeList := StackAlloc(MaxStroke * sizeof(Integer));
      FillDWord(StrokeList^, MaxStroke, 2);
{$ENDIF}

      if ColorToRGB(FInternalColor) = clSilver then
        LineColor := clGray;
      DrawLines(goFixedHorzLine in Options, goFixedVertLine in Options,
        0, 0, [0, 0, Horz.FixedBoundary, Vert.FixedBoundary], LFixedBorderColor, LFixedColor);
      DrawLines(goFixedHorzLine in Options, goFixedVertLine in Options,
        LeftCol, 0, [Horz.FixedBoundary, 0, Horz.GridBoundary,
        Vert.FixedBoundary], LFixedBorderColor, LFixedColor);
      DrawLines(goFixedHorzLine in Options, goFixedVertLine in Options,
        0, TopRow, [0, Vert.FixedBoundary, Horz.FixedBoundary,
        Vert.GridBoundary], LFixedBorderColor, LFixedColor);
      DrawLines(goHorzLine in Options, goVertLine in Options, LeftCol,
        TopRow, [Horz.FixedBoundary, Vert.FixedBoundary, Horz.GridBoundary,
        Vert.GridBoundary], LineColor, FInternalColor);

{$IF DEFINED(CLR)}
      SetLength(StrokeList, 0);
      SetLength(PointsList, 0);
{$ELSE}
      StackFree(StrokeList);
      StackFree(PointsList);
{$ENDIF}
    end;

    { Draw the cells in the four areas }
    Sel := Selection;
    FrameFlags1 := 0;
    FrameFlags2 := 0;
    if goFixedVertLine in Options then
    begin
      FrameFlags1 := BF_RIGHT;
      FrameFlags2 := BF_LEFT;
    end;
    if goFixedHorzLine in Options then
    begin
      FrameFlags1 := FrameFlags1 or BF_BOTTOM;
      FrameFlags2 := FrameFlags2 or BF_TOP;
    end;
    DrawCells(0, 0, 0, 0, Horz.FixedBoundary, Vert.FixedBoundary, LFixedColor,
      [gdFixed]);
    DrawCells(LeftCol, 0, Horz.FixedBoundary - FColOffset, 0, Horz.GridBoundary,  //!! clip
      Vert.FixedBoundary, LFixedColor, [gdFixed]);
    DrawCells(0, TopRow, 0, Vert.FixedBoundary, Horz.FixedBoundary,
      Vert.GridBoundary, LFixedColor, [gdFixed]);
    DrawCells(LeftCol, TopRow, Horz.FixedBoundary - FColOffset,                   //!! clip
      Vert.FixedBoundary, Horz.GridBoundary, Vert.GridBoundary, FInternalColor, []);

    if not (csDesigning in ComponentState) and
       (goRowSelect in Options) and DefaultDrawing and Focused then
    begin
      GridRectToScreenRect(GetSelection, FocRect, False);
      Canvas.Brush.Style := bsSolid;
      if (FInternalDrawingStyle = gdsThemed) and (Win32MajorVersion >= 6) and
         not TStyleManager.IsCustomStyleActive then
        InflateRect(FocRect, -1, -1);
      AFocRect := FocRect;
      if TStyleManager.IsCustomStyleActive then
        DrawStyleFocusRect(Canvas.Handle, AFocRect)
      else if not UseRightToLeftAlignment then
        Canvas.DrawFocusRect(AFocRect)
      else
      begin
        AFocRect := FocRect;
        AFocRect.Left := FocRect.Right;
        AFocRect.Right := FocRect.Left;
        DrawFocusRect(Canvas.Handle, AFocRect);
      end;
    end;

    { Fill in area not occupied by cells }
    if not (seClient in StyleElements) then FInternalColor := Color;
    if Horz.GridBoundary < Horz.GridExtent then
    begin
      Canvas.Brush.Color := FInternalColor;
      Canvas.FillRect(Rect(Horz.GridBoundary, 0, Horz.GridExtent, Vert.GridBoundary));
    end;
    if Vert.GridBoundary < Vert.GridExtent then
    begin
      Canvas.Brush.Color := FInternalColor;
      Canvas.FillRect(Rect(0, Vert.GridBoundary, Horz.GridExtent, Vert.GridExtent));
    end;
  end;

  if UseRightToLeftAlignment then ChangeGridOrientation(False);
end;


end.
