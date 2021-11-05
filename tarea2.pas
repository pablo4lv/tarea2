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
        if EsPosicionValida(f,c) and ( t[f,c].tipo = libre ) then
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
  var p: ListaPos; po: Posicion; a, b: integer;
    begin
	  po.fila:=f;
	  po.columna:=c;
	  Desocultar(f,c,t,p);
      while p <> nil do
        begin
		  a:= po.fila; b:= po.columna;
		  DesocultarAdyacentes(a, b, t, p);
		  PrimeraPosicion(po,p);
        end;
    end;
    
function EsTableroCompleto(t : Tablero) : boolean;
  var aux: boolean; i, j : integer;
    begin
	  aux:= true;
      i:= 1; j:= 1;
      while ( i <= CANT_FIL ) and aux do
        begin
          while (j <= CANT_COL ) and aux do
            begin
              aux:= ( t[i,j].oculto ) and ( t[i,j].tipo = libre );
              j:= j + 1;
            end;
        i:= i + 1;
        end;
      EsTableroCompleto:= aux;  
    end;
