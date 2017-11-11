unit Bowling.API;

interface

type
  IBowlingGame = interface
  ['{1339C127-3DEB-4B24-9F80-1A929A99BD88}']
    procedure Roll(Pins: Integer);
    function Score: Integer;
  end;

implementation

end.