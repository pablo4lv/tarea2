procedure IniciarTableroVacio (var t : Tablero);
var i, J: integer;
  begin
    for i:=1 to CANT_FIL do
      for j:=1 to CANT_COL do
        with t[i,j] do
          begin
            oculto:= true;
            tipo:= libre;          
            minasAlrededor:= 0
          end
  end;
