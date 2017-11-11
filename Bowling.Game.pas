unit Bowling.Game;

interface

uses
  Bowling.API;

type
  TBowlingGame = class(TInterfacedObject, IBowlingGame)
  private
    FRolls: array[0..20] of Integer;
    FCurrentRollIndex: Integer;
    function IsStrike(const FrameStartIndex: Integer): Boolean;
    function IsSpare(const FrameStartIndex: Integer): Boolean;
    function SumTwoConsecutiveRolls(const StartIndex: Integer): Integer;
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
    if IsStrike(FrameStartIndex) then
    begin
      Result := Result + 10 + SumTwoConsecutiveRolls(FrameStartIndex + 1);
      Inc(FrameStartIndex, 1);
    end
    else
    begin
      if IsSpare(FrameStartIndex) then
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

function TBowlingGame.IsStrike(const FrameStartIndex: Integer): Boolean;
begin
  Result := FRolls[FrameStartIndex] = 10;
end;

function TBowlingGame.IsSpare(const FrameStartIndex: Integer): Boolean;
begin
  Result := SumTwoConsecutiveRolls(FrameStartIndex) = 10;
end;

function TBowlingGame.SumTwoConsecutiveRolls(const StartIndex: Integer): Integer;
begin
  Result := FRolls[StartIndex] + FRolls[StartIndex + 1];
end;

end.