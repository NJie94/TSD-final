#include <stdio.h>
#include "Polygon.h.h"

int main(void)
{
	Polygon *plg;
	int num_Vertices=0;
	int i=0;
	FILE *poly_wfile;
	FILE *poly_rfile;
	int num;
	double area= 0.0;
	
	printf("How many Vertices you have?");
	scanf("%i",&num_Vertices);
	fflush(stdin);
	
	double xCoordinates[num_Vertices];
	double yCoordinates[num_Vertices];
	
	for(i=0;i<num_Vertices;i++)
	{
		printf("Enter the coordinates: %i\n",i+1);
		printf("Xcoordinate\n");
        scanf("%lf", &xCoordinates[i]);
		fflush(stdin);
		
		printf("YCoordinate\n");
		scanf("%lf", &yCoordinates[i]);
			
		fflush(stdin); 	   
	}

	poly_wfile=fopen("plg_wfile.txt", "w");
	poly_rfile=fopen("plg_wfile.txt", "r");
		if (poly_wfile==NULL||poly_rfile==NULL)
	{
		printf("Error opening input file \n");
	}
	else 
	{
	
		printf("succesful file\n");
	} 
	
	
		plg_write(xCoordinates,yCoordinates,poly_wfile,num_Vertices);
		plg = plg_read(plg, poly_rfile,num_Vertices);
		
		area = plg_getArea(plg,num_Vertices);
		printf("Area of polygon:%5.2lf\n",area);/*print out the area of polygon which calculated*/
	 
		plg_delete(plg);
	
		fclose(poly_wfile);
		fclose(poly_rfile);



return 0;
}

