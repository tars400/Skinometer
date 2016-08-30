function [ TDV ] = Total_Res(input)
[Asymmtry,CI]=Asym(input);
[VI]=Edgevar(input);
[fractal]=Fractal_Dim(input);
[ l,lg ] = Pigment_Trans(input);
[black ,white ,red ,blue ,dark_brown ,light_brown] = Color_Histo( input );
if(black~=0)
    b=1;
    else
    b=0;
end
if(white~=0)
    w=1;
else
    w=0;
end
if(red~=0)
    r=1;
   else
    r=0;
end
if(blue~=0)
    bl=1;
    else
    bl=0;
end
if(dark_brown~=0)
    d=1;
    else
    d=0;
end
if(light_brown~=0)
    li=1;
    else
    li=0;
end
 [ DIA ] = Diameter( input );
 if(DIA>=22.6772)
     dia=5;
 else
     dia=DIA;
 end
 
 A=1.3*Asymmtry;
 A
 
 B=0.1*(CI+VI+fractal+l+lg);
 B
 
 C=0.5*(w+b+r+bl+d+li);
 C
 
 D=0.5*dia;
 D

 TDV=(A+B+C+D);  %total dermotoscopic value

 
 if(TDV >= 5.25)
     {
         fprintf('Malignant skin,contains Malanoma,Please consult a Dermatologist');
    }
 else if(TDV >=4.75 && TDV <=5.25)
       {
             fprintf('Suspicious, Consult a Dermatologist');
             }
     else
         {
            fprintf('Benign skin lesion : No Melanoma Content');
         }
     end
 end    
