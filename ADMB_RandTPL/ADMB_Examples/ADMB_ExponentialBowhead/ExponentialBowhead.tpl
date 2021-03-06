////////////// ADMB Example: Exponential Bowhead ///////////////////////

DATA_SECTION
   // Data read in from filename.DAT where filename = same name as this .tpl file
   // No differentiable info in this section
   // Start with init when read from .DAT file
   // Must read in data in the order it appears in .DAT file

   init_int lengthObs;
   init_vector Abund;
   init_vector CV;
   init_vector Years;



PARAMETER_SECTION
   // Model parameters to estimate, global variables, real numbers and objective function (no int variables allowed)
  
  init_number r;
  init_number logNzero; // log initial Abundance (Nzero) so value is positive
  
  sdreport_vector Npred(1978,2002); // Reports standard error in .std and .cor files

 
 // Objective function
 objective_function_value objfun; // must have objective function to minimize



PROCEDURE_SECTION
   // Includes calculations and the objective function to minimize
   // Section must start at margin or it causes problems

   // Various expresions
     // mfexp() better than exp()
     // sqrt(); // returns square root
     // posfunc(variablename, eps, penalty); keeps value positive, adds penalty to objfun if negative
     // elem_prod(vector1, vector2); // element multiplication
     // elem_div(vector1, vector2); // element division
     // det(matrix); // determinant
     // inv(matrix); // inverse
     // trans(matrix); // transpose

   // Data management
     // column(matrix,index); // returns column index (e.g. column 1 for index=1) as a vector
     // extract_row(matrix,index); // returns row as a vector
     // extract_diagonal(matrix); // returns diagonal of matrix
     // VectorName(ivector); // indexes by position
     // VectorName(index1,index2); // pull out range of vector values
   // Functions belong here & may be used to break up code, can be called to do things but doesn't return an object


   // Convert from log to normal space
   par1 = mfexp(logpar1);

   // Convert from logit to normal space
   par2 = mfexp(logitpar2)/(1.0 + mfexp(logitpar2));
 
   // Loop over local variable Year from 1:10
   for (int Year=1;Year<=10;Year++){ 
     SumSquares += 1;
   }

   objfun = SumSquares;  
   cout << SumSquares << endl; // Print to screen, no !! needed since C++ commands understood in PROCEDURE_SECTION


   // Dummy Example Procedure 
   ypred = a + b*x;
 


 FUNCTION testfuncction
   // May define function temporary variables here

   int tempvariable; // tempvariable is a local(?) integer

   dvariable tempreal; // tempreal is a differentiable real number

   float tempfloat; // tempfloat is a non-differentiaable real number

   dvar_vector tempvector; // tempvector is a vector of differentiable real numbers
   
   // REST OF FUNCTION HERE !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!




REPORT_SECTION
   // Print to .REP file
 report << "print first parameter to in report with this message in .REP file" << par1 << endl;

 // If your code isn't working check the following
   // Section headings must start at the margin, but code following section headings must be indented 1 or more spaces (usually 2)
   // Must have an objective_function_value
   // Ensure no int variables in PARAMETER_SECTION
   // Make sure everything is in bounds (weird errors if things aren't indexed correctly & stored in vectors/matrices of the correct size)
   // Ensure .DAT, .PIN, and .TPL files are in same (and current) working directory
   // Make sure previous .par, .std, and .cor files from previous runs have been deleted so that you can check that these are updated & reproduced after debugging
   // ensure all lines end with ;
   // Make sure estimated parameters aren't used in if statements or conditional statements, this could add a discontinutiy when you are trying to solve for the optimal parameter value
   // Ensure local variables declared in advance and given starting value (often set to zero)
 
 // To run, type in ADMB terminal:
    // admb filename.TPL
    // filename - nohess // if you don't want hessian
    // filename // to run as is with hessian

