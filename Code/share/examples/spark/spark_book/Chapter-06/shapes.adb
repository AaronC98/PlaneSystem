pragma SPARK_Mode(On);

package body Shapes is

   function Inside_Circle
     (X, Y : Coordinate_Type; C : Circle) return Boolean is

      subtype Full_Width_Type is Integer range 0 .. 2*Coordinate_Type'Last;
      Delta_X : Full_Width_Type;
      Delta_Y : Full_Width_Type;
   begin
      Delta_X := Full_Width_Type(abs (X - C.Center_X));
      Delta_Y := Full_Width_Type(abs (Y - C.Center_Y));
      return Delta_X*Delta_X + Delta_Y*Delta_Y <= Full_Width_Type(C.Radius*C.Radius);
   end Inside_Circle;

end Shapes;
