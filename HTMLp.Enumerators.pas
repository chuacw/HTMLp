unit HTMLp.Enumerators;

interface

uses
  HTMLp.DomCore; // System.SysUtils

type
  TNodeListEnumerator = class
  protected
    FNodeList: TNodeList;
    FIndex: Integer;
    function GetCurrent: TNode; virtual;
  public
    constructor Create(const ANodeList: TNodeList);
    destructor Destroy; override;
    function GetEnumerator: TNodeListEnumerator;

    function MoveNext: Boolean; virtual;
    property Current: TNode read GetCurrent;
  end;

  TNamedNodeMapEnumerator = class(TNodeListEnumerator);

function Enumerator(const ANodeList: TNodeList): TNodeListEnumerator; overload;
function Enumerator(const ANodeMap: TNamedNodeMap): TNamedNodeMapEnumerator; overload;

implementation

function Enumerator(const ANodeList: TNodeList): TNodeListEnumerator;
begin
  Result := TNodeListEnumerator.Create(ANodeList);
end;

function Enumerator(const ANodeMap: TNamedNodeMap): TNamedNodeMapEnumerator;
begin
  Result := TNamedNodeMapEnumerator.Create(ANodeMap);
end;

{ TNodeListEnumerator }

constructor TNodeListEnumerator.Create(const ANodeList: TNodeList);
begin
  inherited Create;
  FNodeList := ANodeList;
  FIndex := -1;
end;

destructor TNodeListEnumerator.Destroy;
begin
  inherited;
end;

function TNodeListEnumerator.GetCurrent: TNode;
begin
  Result := FNodeList[FIndex];
end;

function TNodeListEnumerator.GetEnumerator: TNodeListEnumerator;
begin
  Result := Self;
end;

function TNodeListEnumerator.MoveNext: Boolean;
begin
  Result := FIndex < FNodeList.Count - 1;
  if Result then
    Inc(FIndex);
end;

end.
