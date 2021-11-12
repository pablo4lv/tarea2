procedure IniciarTableroVacio (var t : Tablero);
  var i, J: integer;
    begin
      for i:=1 to CANT_FIL do
        for j:=1 to CANT_COL do
          with t[i,j] do
            begin
             oculto:= true;
             tipo:= Libre;          
             minasAlrededor:= 0
            end;
    end;

procedure DesocultarMinas (var t : Tablero);
  var i, J: integer;
    begin
      for i:=1 to CANT_FIL do
        for j:=1 to CANT_COL do
          if (t[i,j].tipo = Mina) then
            t[i,j].oculto:= false
    end;
  
function EsPosicionValida (f, c : integer) : boolean;
  var aux : boolean;
    begin
      aux:= ( f >= 1 ) and ( f <= CANT_FIL ) and ( c >= 1 ) and ( c <= CANT_COL );
      EsPosicionValida:= aux
    end;
    
procedure AgregarMinas (m : Minas; var t : Tablero);
  var i, j, k, x, y: integer;
    begin
      for i:=1 to m.tope do
      begin
        if EsPosicionValida( m.elems[i].fila , m.elems[i].columna ) then
          begin
            t[m.elems[i].fila , m.elems[i].columna].tipo:= mina;
            x:= m.elems[i].fila - 1;
            y:= m.elems[i].columna - 1;
              for j:= 1 to 3 do
                begin
                  for k:= 1 to 3 do
                    begin
                      if EsPosicionValida(x,y) then
                        if t[x,y].tipo <> mina then
                          t[x,y].minasAlrededor:= t[x,y].minasAlrededor + 1;
                      x:= x + 1;
                    end;
                  x:= m.elems[i].fila - 1;
                  y:= y + 1;
                end;
          end;
      end;
    end;

procedure Desocultar (f, c : integer; var t : Tablero; var libres : ListaPos);
    var pos: Posicion;
      begin
        if EsPosicionValida(f,c) and ( t[f,c].tipo = libre ) and (t[f,c].oculto) then
          begin
            t[f,c].oculto:= false;
            if t[f,c].minasAlrededor = 0 then
              begin
                pos.fila:= f;
                pos.columna:= c;
                AgregarAlFinal(pos,libres);
              end;
          end;    
      end;
      
procedure DesocultarAdyacentes (f, c : integer; var t : Tablero; var libres : ListaPos);    
  var i, j, x, y:integer;
    begin
      x:= f - 1;
      y:= c - 1;
      for i:= 1 to 3 do
        begin
          for j:= 1 to 3 do
            begin
              Desocultar(x,y,t,libres);
              x:= x + 1;
            end;
          x:= f - 1;
          y:= y + 1;  
        end;
    end;
    
procedure DesocultarDesde (f : RangoFilas;  c : RangoColum; var t : Tablero);    
  var p: ListaPos; po: Posicion;
    begin
	  po.fila:=f;
	  po.columna:=c;
	  new(p);
	  Desocultar(f,c,t,p);
      while p <> nil do
        begin
		  PrimeraPosicion(po,p);
		  DesocultarAdyacentes(po.fila, po.columna, t, p);
        end;
    end;
    
function EsTableroCompleto(t : Tablero) : boolean;
  var aux: boolean; i, j : integer;
    begin
	  aux:= true;
      i:= 1; j:=1;
      while ( i <= CANT_FIL ) and aux do
        begin
          while ( j <= CANT_COL ) and aux do
            begin
              aux:= not( (t[i,j].oculto) and (t[i,j].tipo = libre) );
              j:= j + 1;
            end;
	j:=1;
        i:= i + 1;
        end;
      EsTableroCompleto:= aux;  
    end;

















































































procedure IniciarTableroVacio (var t : Tablero); 
var
  a,b:integer;
begin
    for a:= 1 to CANT_FIL do
      for b:= 1 to CANT_COL do
      begin
      t[a,b].oculto:=true;
      t[a,b].tipo:=Libre;
      t[a,b].minasAlrededor:=0;
      end
end;

procedure DesocultarMinas (var t : Tablero);
var
  a,b:integer;
begin
  for a:= 1 to CANT_FIL do
    for b:= 1 to CANT_COL do
    begin
      if t[a,b].tipo = Mina then
        t[a,b].oculto:=false;
    end
end;

function EsPosicionValida (f, c : integer) : boolean;
begin
  if (((f<=CANT_FIL)and(f>=1))and((c>=1)and(c<=CANT_COL))) then
    EsPosicionValida:=true
  else
    EsPosicionValida:=false;
end;

procedure AgregarMinas (m : Minas; var t : Tablero);
var
  ap,bp,a,b,c,n,v:integer;
begin
  for c:=1 to m.tope do
  begin
  n:=m.elems[c].fila;
  v:=m.elems[c].columna;
    if EsPosicionValida(n,v) then
    begin
      ap:=n-2;  bp:=v-2;
      t[m.elems[c].fila,m.elems[c].columna].tipo:=mina;
        for a:=1 to 3 do
        begin
          ap:=n-2;  bp:=bp+1;
          for b:=1 to 3 do
          begin
            ap:=ap+1;
            if EsPosicionValida(ap,bp) then
              if t[ap,bp].tipo<>mina then
                t[ap,bp].minasAlrededor:=t[ap,bp].minasAlrededor+1;
          end;     
        end;
    end;
  end;
end;

procedure Desocultar (f, c : integer; var t : Tablero; var libres : ListaPos);
var pos: Posicion;
begin
  if EsPosicionValida(f,c) and ( t[f,c].tipo = libre ) and (t[f,c].oculto) then
  begin
    t[f,c].oculto:= false;
    if t[f,c].minasAlrededor = 0 then
    begin
      pos.fila:= f;
      pos.columna:= c;
      AgregarAlFinal(pos,libres);
    end;
  end;    
end;
      
procedure DesocultarAdyacentes (f, c : integer; var t : Tablero; var libres : ListaPos);    
var i, j, x, y:integer;
begin
  x:= f - 1;  y:= c - 1;
  for i:= 1 to 3 do
  begin
    for j:= 1 to 3 do
    begin
      Desocultar(x,y,t,libres);
      x:= x + 1;
    end;
    x:=f-1;  y:=y+1;
  end;
end;

procedure DesocultarDesde (f : RangoFilas;  c : RangoColum; var t : Tablero);    
var p: ListaPos; po: Posicion;
begin
  po.fila:=f;
  po.columna:=c;
  new(p);
  p^.pos:=po;
  p^.sig:=nil;
  Desocultar(f,c,t,p);
  PrimeraPosicion(po,p);
  while p <> nil do
  begin
    PrimeraPosicion(po,p);
    Desocultar(f,c,t,p);
    DesocultarAdyacentes(po.fila, po.columna, t, p);
  end;
end;

function EsTableroCompleto(t : Tablero) : boolean;
var
  a,b:integer;
  aux:boolean;
begin
a:=1;
b:=1;
aux:=true;
  while ((a<=CANT_FIL)and(aux)) do
  begin
    b:=1;
    while ((b<=CANT_COL)and(aux)) do
    begin
      aux:=not((t[a,b].oculto) and (t[a,b].tipo = libre));
      b:=b+1;
    end;
    a:=a+1;
  end;
  EsTableroCompleto:=aux;
end;
