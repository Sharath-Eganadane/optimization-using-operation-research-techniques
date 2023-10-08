/*********************************************
 * OPL 20.1.0.0 Model
 * Author: Sharath Eganadane
 * Creation Date: 27-Mar-2022 at 6:18:44 pm
 *********************************************/
//count

int m=...;
int n=...;

//sets

range F = 1..m;  //set of foods 
range I = 1..n;  //set of ingredients

//Parameters

float C[F]=...;    //Cost of food type f
float A[I][F]=...; //Amount of ingredients i in one unit of food type f
int P[F]=...;      //Priority rating for food type f
float A_max[I]=...;//Maximum value of ingredients needed
float A_min[I]=...;//Minimum value of ingredients needed
int B=...;         //Budget

//Decision Variable

dvar boolean X[F]; 

execute
{
  cplex.tilim=1800;
}


//Objective Function

minimize sum(f in F) X[f]*P[f];


//constraints

subject to
{constraint1: 0 <= sum(f in F)  X[f] * C[f] <= B;
forall (i in I) constraint2: sum(f in F) X[f]*A[i][f] <= A_max[i];
forall (i in I) constraint3: sum(f in F) X[f]*A[i][f] >= A_min[i];
}

execute
{
  var file = new IloOplOutputFile ("Optimum_Diet.csv");
  file.writeln("Objective Value =",cplex.getObjValue());
  for (var f in F)
  {
    file.writeln("X[",f,"]","=",X[f].solutionValue,",");
  }
}


