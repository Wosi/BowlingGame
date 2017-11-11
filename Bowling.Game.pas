unit Bowling.Game;

interface

uses
  Bowling.API;

type
  TBowlingGame = class(TInterfacedObject, IBowlingGame)
  private
    FRolls: array[0..20] of Integer;
    FCurrentRollIndex: Integer;
  public
    constructor Create;
    procedure Roll(Pins: Integer);
    function Score: Integer;
  end;

implementation

procedure TBowlingGame.Roll(Pins: Integer);
begin
  FRolls[FCurrentRollIndex] := Pins;
  Inc(FCurrentRollIndex);
end;

function TBowlingGame.Score: Integer;
var
  FrameStartIndex: Integer;
  Frame: Integer;
begin
  Result := 0;
  FrameStartIndex := 0;
  for Frame := 0 to 10 -1 do
  begin
    if FRolls[FrameStartIndex] = 10 then
    begin
      Result := Result + 10 + FRolls[FrameStartIndex + 1] + FRolls[FrameStartIndex + 2];
      Inc(FrameStartIndex, 1);
    end
    else
    begin
      if FRolls[FrameStartIndex] + FRolls[FrameStartIndex + 1] = 10 then
      begin
        Result := Result + 10 + FRolls[FrameStartIndex + 2];
        Inc(FrameStartIndex, 2);
      end
      else
      begin
        Result := Result + FRolls[FrameStartIndex] + FRolls[FrameStartIndex + 1];
        Inc(FrameStartIndex, 2);
      end;
    end;
  end;
end;

constructor TBowlingGame.Create;
var
  I: Integer;
begin
  inherited;
  FCurrentRollIndex := 0;
  for I := 0 to Length(FRolls) - 1 do
    FRolls[I] := 0;
end;

end.