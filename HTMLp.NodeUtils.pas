unit HTMLp.NodeUtils;

interface

uses
  HTMLp.DomCore, System.SysUtils, HTMLp.Enumerators;

function FindElement(const ANodeList: TNodeList;
  const AFunc: TFunc<TNode, Boolean>): TNode;

type
  TNodeHelper = class helper for TNode
  public
    function getAttribute(const AName: string): string;
    function _className: string;
  end;

  TDocumentHelper = class helper for TDocument
  protected
    function GetBody: TElement;
  public
    property Body: TElement read GetBody;
  end;

  TNodeListHelper = class helper for TNodeList
  public
    function GetEnumerator: TNodeListEnumerator;
  end;

implementation

function FindElement(const ANodeList: TNodeList;
  const AFunc: TFunc<TNode, Boolean>): TNode;
var
  I: Integer;
  LNode: TNode;
begin
  Result := nil;
  if Assigned(ANodeList) then
    begin
      for I := 0 to ANodeList.Count-1 do
        begin
          LNode := ANodeList[I];
          if AFunc(LNode) then
            Exit(LNode);
        end;
    end;
end;

{ TNodeHelper }

function TNodeHelper.getAttribute(const AName: string): string;
var
  LAttrNode: TNode;
begin
  Result := '';
  if HasAttributes then
    begin
      LAttrNode := Attributes[AName];
      if Assigned(LAttrNode) then
        Exit(LAttrNode.Value);
    end;
end;

function TNodeHelper._className: string;
begin
  Result := getAttribute('class');
end;

{ TDocumentHelper }

function TDocumentHelper.GetBody: TElement;
begin
  Result := DocumentElement.ChildNodes['body'] as TElement;
end;

{ TNodeListHelper }

function TNodeListHelper.GetEnumerator: TNodeListEnumerator;
begin
  Result := TNodeListEnumerator.Create(Self);
end;

end.
