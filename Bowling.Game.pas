unit Bowling.Game;

interface

uses
  Bowling.API;

type
  TBowlingGame = class(TInterfacedObject, IBowlingGame)
  private
    type
      TBowlingFrame = record
        Score: Integer;
        Size: Integer;
      end;
  private
    FRolls: array[0..20] of Integer;
    FCurrentRollIndex: Integer;
    function IsStrike(const FrameStartIndex: Integer): Boolean;
    function IsSpare(const FrameStartIndex: Integer): Boolean;
    function SumTwoConsecutiveRolls(const StartIndex: Integer): Integer;
    function CreateFrameInfo(const FrameStartIndex: Integer): TBowlingFrame;
    function CreateStrikeFrame(const FrameStartIndex: Integer): TBowlingFrame;
    function CreateSpareFrame(const FrameStartIndex: Integer): TBowlingFrame;
    function CreateNonBonusFrame(const FrameStartIndex: Integer): TBowlingFrame;
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
  FrameIndex: Integer;
  Frame: TBowlingFrame;
begin
  Result := 0;
  FrameStartIndex := 0;
  for FrameIndex := 0 to 10 - 1 do
  begin
    Frame := CreateFrameInfo(FrameStartIndex);
    Inc(Result, Frame.Score);
    Inc(FrameStartIndex, Frame.Size);
  end;
end;

function TBowlingGame.CreateFrameInfo(const FrameStartIndex: Integer): TBowlingFrame;
begin
  if IsStrike(FrameStartIndex) then
    Result := CreateStrikeFrame(FrameStartIndex)
  else if IsSpare(FrameStartIndex) then
    Result := CreateSpareFrame(FrameStartIndex)
  else
    Result := CreateNonBonusFrame(FrameStartIndex);
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

function TBowlingGame.CreateStrikeFrame(const FrameStartIndex: Integer): TBowlingFrame;
begin
  Result.Score := 10 + SumTwoConsecutiveRolls(FrameStartIndex + 1);
  Result.Size := 1;
end;

function TBowlingGame.CreateSpareFrame(const FrameStartIndex: Integer): TBowlingFrame;
begin
  Result.Score := 10 + FRolls[FrameStartIndex + 2];
  Result.Size := 2;
end;

function TBowlingGame.CreateNonBonusFrame(const FrameStartIndex: Integer): TBowlingFrame;
begin
  Result.Score := SumTwoConsecutiveRolls(FrameStartIndex);
  Result.Size := 2;
end;

end.