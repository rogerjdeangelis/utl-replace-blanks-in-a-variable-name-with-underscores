Replace blanks in a variable name with underscores;                                                                        
                                                                                                                           
github                                                                                                                     
https://tinyurl.com/yd2nxz3w                                                                                               
https://github.com/rogerjdeangelis/utl-replace-blanks-in-a-variable-name-with-underscores                                  
                                                                                                                           
see SAS Forum                                                                                                              
https://tinyurl.com/yd7f7q5z                                                                                               
https://communities.sas.com/t5/SAS-Data-Management/Replacing-quot-quot-with-a-quot-quot-for-variable-names-in-a/td-p/174192
                                                                                                                           
                                                                                                                           
Repository macros                                                                                                          
https://tinyurl.com/y9nfugth                                                                                               
https://github.com/rogerjdeangelis/utl-macros-used-in-many-of-rogerjdeangelis-repositories                                 
                                                                                                                           
                                                                                                                           
INPUT                                                                                                                      
=====                                                                                                                      
                                                                                                                           
40 obs from have total obs=19                                                                                              
                                                                                                                           
            Student    Student                                                                                             
 Name         Sex        Age      Height    Weight                                                                         
                                                                                                                           
 Alfred        M          14       69.0      112.5                                                                         
 Alice         F          13       56.5       84.0                                                                         
 Barbara       F          13       65.3       98.0                                                                         
 Carol         F          14       62.8      102.5                                                                         
 Henry         M          14       63.5      102.5                                                                         
 James         M          12       57.3       83.0                                                                         
 Jane          F          12       59.8       84.5                                                                         
                                                                                                                           
  Variables in Creation Order                                                                                              
                                                                                                                           
#    Variable       Type    Len                                                                                            
                                  RULE RENAME                                                                              
1    Name           Char      8                                                                                            
2    Student Sex    Char      1   Student_Sex                                                                              
3    Student Age    Num       8   Student_Age                                                                              
4    Height         Num       8                                                                                            
5    Weight         Num       8                                                                                            
                                                                                                                           
EXAMPLE OUTPUT                                                        
--------------                                                        
                                                                      
  Variables in Creation Order                                         
                                                                      
#    Variable       Type    Len                                       
                                                                      
1    Name           Char      8                                       
2    Student_Sex    Char      1                                       
3    Student_Age    Num       8                                       
4    Height         Num       8                                       
5    Weight         Num       8                                       
                                                                      
Data Set Name        WORK.WANT             Observations          19   
Member Type          DATA                  Variables             5    
                                                                      
                                                                                                                           
PROCESS                                                                                                                    
=======                                                                                                                    
                                                                                                                           
%let vars= %unquote(%varlist(have,qstyle=ORACLE));                                                                         
%let varcnt=%eval(%sysfunc(count(&vars,%str(%" %")))+1);                                                                   
                                                                                                                           
/*                                                                                                                         
%put &=vars;                                                                                                               
%put &=varcnt;                                                                                                             
                                                                                                                           
VARS="Name" "Student Sex" "Student Age" "Height" "Weight"                                                                  
VARCNT=5                                                                                                                   
*/                                                                                                                         
                                                                                                                           
data log;                                                                                                                  
  length ren $32756;                                                                                                       
  array nums[&varcnt] $32 ( &vars );                                                                                       
  do idx=1 to dim(nums);                                                                                                   
     ren=catx(' ',ren,cats("'",nums[idx],"'n"),"=",translate(strip(nums[idx]),'_',' '));                                   
  end;                                                                                                                     
  call symputx('rens',ren);                                                                                                
  rc=dosubl("                                                                                                              
     data want;                                                                                                            
       set have(rename=( &rens ));                                                                                         
     run;quit;                                                                                                             
  ");                                                                                                                      
run;quit;                                                                                                                  
                                                                                                                           
LOG                                                                                                                        
===                                                                                                                        
                                                                                                                           
838   data log;                                                                                                            
839     length ren $32756;                                                                                                 
840     array nums[&varcnt] $32 ( &vars );                                                                                 
SYMBOLGEN:  Macro variable VARCNT resolves to 5                                                                            
SYMBOLGEN:  Macro variable VARS resolves to "Name" "Student Sex" "Student Age" "Height" "Weight"                           
841     do idx=1 to dim(nums);                                                                                             
842        ren=catx(' ',ren,cats("'",nums[idx],"'n"),"=",translate(strip(nums[idx]),'_',' '));                             
843     end;                                                                                                               
844     call symputx('rens',ren);                                                                                          
845     rc=dosubl("                                                                                                        
846        data want;                                                                                                      
847          set have(rename=( &rens ));                                                                                   
SYMBOLGEN:  Macro variable RENS resolves to                                                                                
'Name'n = Name 'Student Sex'n = Student_Sex 'Student Age'n = Student_Age 'Height'n = Height 'Weight'n = Weight             
848        run;quit;                                                                                                       
849     ");                                                                                                                
850   run;                                                                                                                 
                                                                                                                           
NOTE: There were 19 observations read from the data set WORK.HAVE.                                                         
NOTE: The data set WORK.WANT has 19 observations and 5 variables.                                                          
NOTE: DATA statement used (Total process time):                                                                            
      real time           0.04 seconds                                                                                     
                                                                                                                           
NOTE: The data set WORK.LOG has 1 observations and 8 variables.                                                            
NOTE: DATA statement used (Total process time):                                                                            
      real time           0.85 seconds                                                                                     
                                                                                                                           
*                _               _       _                                                                                 
 _ __ ___   __ _| | _____     __| | __ _| |_ __ _                                                                          
| '_ ` _ \ / _` | |/ / _ \   / _` |/ _` | __/ _` |                                                                         
| | | | | | (_| |   <  __/  | (_| | (_| | || (_| |                                                                         
|_| |_| |_|\__,_|_|\_\___|   \__,_|\__,_|\__\__,_|                                                                         
                                                                                                                           
;                                                                                                                          
                                                                                                                           
%symdel vars varcnt / nowarn;                                                                                              
proc datasets lib=work;                                                                                                    
 delete want;                                                                                                              
run;quit;                                                                                                                  
                                                                                                                           
options validvarname=any;                                                                                                  
data have;                                                                                                                 
 set sashelp.class(rename=(                                                                                                
   age='Student Age'n                                                                                                      
   sex='Student Sex'n                                                                                                      
));                                                                                                                        
run;quit;                                                                                                                  
                                                                                                                           
                                                                                                                           
                                                                                                                           
