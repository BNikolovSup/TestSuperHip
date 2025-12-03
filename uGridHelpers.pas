unit uGridHelpers;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  Vcl.Graphics, Tee.Grid, Tee.Grid.Columns, Tee.GridData,
  Tee.Control, Tee.Grid.Header, Tee.Grid.Rows, VCLTee.Grid,
  Vcl.Controls, Math, Tee.Renders, Tee.GridData.Strings,  Aspects.Collections,
  Vcl.Grids, Tee.Painter;



type

  TDiffCellRenderer = class(TCellRender)
  public
    FGrid: TTeeGrid;
    FCollAdb: TBaseCollection;
    procedure Paint(var AData:TRenderData); override;
  end;

  TMultiSortableHeader = class(TSortableHeader)
  private
    FGrid: TTeeGrid;
    FCollForSort: TBaseCollection;
    FHoverColumn: Integer;

    function GetSortOrderInfo(const AColumn: TColumn;
        out Direction: Integer; out OrderNumber: Integer): Boolean;
    procedure SetHoverColumn(const Value: Integer);
  public
    procedure Paint(var AData: TRenderData); override;
    property Grid: TTeeGrid read FGrid write FGrid;
    property CollForSort: TBaseCollection read FCollForSort write FCollForSort;
    property HoverColumn: Integer read FHoverColumn write SetHoverColumn;
  end;

implementation

{ === TMultiSortableHeader ================================================== }

function TMultiSortableHeader.GetSortOrderInfo(const AColumn: TColumn;
  out Direction: Integer; out OrderNumber: Integer): Boolean;
var
  i, colIndex: Integer;
begin
  Result := False;
  Direction := 0;
  OrderNumber := 0;

  if (AColumn = nil) or (FGrid = nil) then Exit;
  if not Assigned(FGrid.Data) then Exit;
  if not Assigned(CollForSort) then Exit;

  colIndex := CollForSort.ArrayPropOrderSearchOptions[AColumn.Index];

  for i := 0 to CollForSort.FSortFields.Count - 1 do
  begin
    if CollForSort.FSortFields[i].PropIndex = colIndex then
    begin
      if CollForSort.FSortFields[i].SortAsc then
        Direction := 1
      else
        Direction := -1;

      OrderNumber := i + 1;

      Result := True;
      Exit;
    end;
  end;
end;

procedure TMultiSortableHeader.Paint(var AData: TRenderData);
var
  R, txtRect: TRectF;
  Column: TColumn;
  colName: string;
  Direction, OrderNum: Integer;
  circleSize, arrowSize, spacing: Single;
  circleRect: TRectF;
  painter: TPainter;
  arrowRect: TRectF;
  MousePos: TPoint;
begin
  inherited;

  if (FGrid = nil)  then //or (not (AData.Data is Integer))
    Exit;

  Column := FGrid.Columns[AData.Data];

  colName := AData.Data;

  painter := AData.Painter;

  // Заглавната област на тази колона
  R.Left   := Column.Left;
  R.Top    := 0;
  R.Width  := Column.Width.Pixels;
  R.Height := FGrid.Header.Height.Pixels;

  MousePos := FGrid.ScreenToClient(Mouse.CursorPos);

  // Фон: малко по-тъмен от дефолтния
  if PtInRect(R, MousePos) then
  begin
    painter.Fill(R, $00EF9C87);
  end
  else
  begin
    painter.Fill(R, $00BCB7BF);
  end;

  // Проверяваме дали колоната участва в сортиране
  if not GetSortOrderInfo(Column, Direction, OrderNum) then
  begin
    // Колоната НЕ участва → само име
    painter.SetTextTrimming(TTrimmingMode.Character, True);

    txtRect := R;
    txtRect.Left := txtRect.Left + 6;

    painter.TextOut(txtRect, colName);
    Exit;
  end;

  painter.SetTextTrimming(TTrimmingMode.Character, True);

  // Настройки на декорацията
  circleSize := R.Height * 0.6;
  arrowSize  := R.Height * 0.6;
  spacing    := 6;

  // Кръгче вдясно
  circleRect.Right  := R.Right - spacing;
  circleRect.Left   := circleRect.Right - circleSize;
  circleRect.Top    := R.CenterPoint.Y - (circleSize / 2);
  circleRect.Bottom := circleRect.Top + circleSize;

  // Рисуваме кръг
  painter.Fill(circleRect, $FFDDDDDD);  // светлосиво

  // Пишем номера в кръга
  painter.SetHorizontalAlign(THorizontalAlign.Center);
  painter.TextOut(circleRect, OrderNum.ToString);

  // Рисуваме стрелката точно вляво от кръга

  arrowRect.Right  := circleRect.Left - spacing;
  arrowRect.Left   := arrowRect.Right - arrowSize;
  arrowRect.Top    := R.CenterPoint.Y - (arrowSize / 2);
  arrowRect.Bottom := arrowRect.Top + arrowSize;

  if Direction = 1 then
    painter.TextOut(arrowRect, '▲')
  else
    painter.TextOut(arrowRect, '▼');

  // Оставяме място за текст
  txtRect := R;
  txtRect.Left := R.Left + spacing;
  txtRect.Right := arrowRect.Left - spacing;

  // Име на колоната
  painter.SetHorizontalAlign(THorizontalAlign.Left);
  painter.TextOut(txtRect, colName);
end;

procedure TMultiSortableHeader.SetHoverColumn(const Value: Integer);
begin
  FHoverColumn := Value;
end;

{ TDiffCellRenderer }

procedure TDiffCellRenderer.Paint(var AData: TRenderData);
var
  RCell : TRectF;
  Column: TColumn;
  CellText: string;
  Painter: TPainter;
  //Coll   : TBaseCollection;
  Diff   : TDiffKind;
begin
  inherited;

  if (FGrid = nil) then
    Exit;

  // Колекцията, която стои зад грида – задаваме я в ShowGrid: Grid.TagObject := Self;
  if (FCollAdb = nil) then
    Exit;



  // Коя колона рисуваме?
  Column := FGrid.Columns.FindAt(AData.Bounds.Left, AData.Bounds.Right);
  if Column = nil then
    Exit;

  // Индекси за колекцията
  // AData.Row е 1-based от грида, ако записите ти са 0-based – извади 1
  Diff := FCollAdb.CellDiffKind(Column.Index, AData.Row);

  RCell   := AData.Bounds;
  Painter := AData.Painter;
  CellText := AData.Data; // текстът от OnGetValue

  // Фон според типа разлика
  case Diff of
    dkNone:
      begin
        Exit;
        // стандартен фон – оставяме TeeGrid да си го е нарисувал (или леко тонираме)
        // Painter.Fill(RCell, $00FFFFFF); // ако искаш бяло
      end;

    dkNew:
      Painter.Fill(RCell, $00C8FFC8);   // светло зелено

    dkChanged:
      Painter.Fill(RCell, $0056E3EF);   // светло жълто

    dkForDeleted:
      Painter.Fill(RCell, $0089BCFA);   // светло червено

    dkDeleted:
      Painter.Fill(RCell, $002020FF);   // светло червено
  end;

  // Подравняване на текста – да не стои “избутан”
  Painter.SetHorizontalAlign(THorizontalAlign.Left);
  Painter.SetVerticalAlign(TVerticalAlign.Center);

  // Малък отстъп вляво
  RCell.Left := RCell.Left + 4;

  Painter.TextOut(RCell, CellText);
end;

//procedure TDiffCellRenderer.Paint(var AData: TRenderData);
//var
//  RCell: TRectF;
//  Column: TColumn;
//  CellText: string;
//  painter: TPainter;
//  MousePos: TPoint;
//begin
//  inherited;
//
//  if (FGrid = nil)  then
//    Exit;
//  MousePos := FGrid.ScreenToClient(Mouse.CursorPos);
//  Column := FGrid.Columns.FindAt(AData.Bounds.Left, AData.Bounds.Right);
//  CellText := AData.Data;
//  RCell := AData.Bounds;
//  painter := AData.Painter;
//  if AData.Row = 3 then
//  begin
//    if Column.Index = 4 then
//    begin
//      painter.Fill(RCell, $00BCB7BF);
//    end
//    else
//    begin
//      painter.Fill(RCell, $00EF9C87);
//    end;
//    painter.SetHorizontalAlign(THorizontalAlign.Left);
//    painter.SetVerticalAlign(TVerticalAlign.Center);
//    painter.TextOut(RCell, CellText);
//  end;
//end;

end.

