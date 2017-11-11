unit TestBowlingGame;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fpcunit, testutils, testregistry, Bowling.API;

type
  TTestBowlingGame= class(TTestCase)
  private
    FGame: IBowlingGame;
    procedure RollMany(const N: Integer; const Pins: Integer);
    procedure RollSpare;
    procedure RollStrike;
  protected
    procedure SetUp; override;
  published
    procedure TestGutterGame;
    procedure TestAllOnes;
    procedure TestOneSpare;
    procedure TestOneStrike;
    procedure TestScoreTenOverFrameBoundaries;
  end;

implementation

uses
  Bowling.Game;

procedure TTestBowlingGame.SetUp;
begin
  FGame := TBowlingGame.Create;
end;

procedure TTestBowlingGame.TestGutterGame;
begin
  RollMany(20, 0);
  CheckEquals(0, FGame.Score);
end;

procedure TTestBowlingGame.TestAllOnes;
begin
  RollMany(20, 1);
  CheckEquals(20, FGame.Score);
end;

procedure TTestBowlingGame.RollMany(const N: Integer; const Pins: Integer);
var
  I: Integer;
begin
  for I := 0 to N -1 do
    FGame.Roll(Pins);
end;

procedure TTestBowlingGame.TestOneSpare;
begin
  RollSpare;
  FGame.Roll(3);
  RollMany(17, 0);

  CheckEquals(16, FGame.Score);
end;

procedure TTestBowlingGame.TestOneStrike;
begin
  RollStrike;
  FGame.Roll(3);
  FGame.Roll(5);
  RollMany(17, 0);

  CheckEquals(26, FGame.Score);
end;

procedure TTestBowlingGame.TestScoreTenOverFrameBoundaries;
begin
  FGame.Roll(0);
  FGame.Roll(5);
  FGame.Roll(5);
  FGame.Roll(3);
  RollMany(16, 0);

  CheckEquals(13, FGame.Score);
end;

procedure TTestBowlingGame.RollSpare;
begin
  FGame.Roll(5);
  FGame.Roll(5);
end;

procedure TTestBowlingGame.RollStrike;
begin
  FGame.Roll(10);
end;

initialization
  RegisterTest(TTestBowlingGame);

end.