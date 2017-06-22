#include <stdio.h>
#include <stdlib.h>

#include "Polygon.h.h"



int main(void)
{
	Polygon *plg;
	FILE *poly_wfile;
	FILE *poly_rfile;
	char file1[100];
	int num_Vertices=0;
	int i=0;
	int num;
	double area= 0.0;
	double perimeter;
	int numOfVertices=0;
	double xCoord[numOfVertices];
	double yCoord[numOfVertices];
	int escape=0;
	int pass=0;
	double hor=0.0;
	double ver = 0.0;
	
	int d;
	do
	{
		d=0;
		printf("Which file are you going to read? \n");
		scanf("%s",&file1);
		
		poly_rfile=fopen(file1, "r");
		fflush(stdin);
		if (poly_rfile==NULL)
				{
					printf("Error opening input file,try to input a right file \n");
					d=1000;
				}
			else
			{
				plg=plg_read(plg, poly_rfile);
				printf("File successful read\n");
			}
		if(d!=1000)
		{
			do
			{
				
				escape = 0;
				printf("Welcome to Polygon Analysing Program\n");
				printf("Menu\n");
				printf("\t 1 Print polygon coordinate\n");
				printf("\t 2.Calculate area\n");
				printf("\t 3.Check Polygon (Polygon / Not Polygon)\n");
				printf("\t 4. Calculate Perimeter\n");
				printf("\t 5. Calculate Centroid\n");
				printf("\t 6. Polygon Type (Regular / Not Regular)\n");
				printf("\t 7. Shift Polygon Horizontally\n");
				printf("\t 8. Shift Polygon Vertically\n");
				printf("\t 9.Do you want to read other file\n");
				printf("\t 10.End program\n");
				
				printf("Enter your choice\n");
				scanf("%i",&d);
				fflush(stdin);
				
				
				
				if(d==1)
				{
					printf("POLYGON COORDINATE\n");
					for(i=0; i<plg->numberOfVertices; i++)
					{
						printf("Coordinate X%i = %lf	Coordinate Y%i = %lf\n",i+1,plg->xCoordinates[i],i+1,plg->yCoordinates[i]);
							
					}
					
				}
				
				if(d==2)
				{	
					pass=plg_close(plg);
					if(pass==1)
					{
					printf("POLYGON AREA\n");
					area = plg_getArea(plg);
					printf("Area of polygon:%5.2lf\n",area);/*print out the area of polygon which calculated*/
					}
					else
					{
						printf("This is not a polygon!\n");
					}
				}
				if(d==3)
				{
					printf("CHECK POLYGON\n");
					pass=plg_close(plg);
					if(pass==1)
							{
								printf("Polygon\n");
							}
							if(pass==2)
							{
								printf("Not Polygon\n");
							}
				}
				
				if(d==4)
				{	pass=plg_close(plg);
					if(pass==1)
					{
						printf("POLYGON PERIMETER\n");
						printf("Total perimeter =%lf\n",plg_getPerimeter(plg));
					}
					else
					{
						printf("This is not a polygon!\n");
					}
				}
				if(d==5)
				{
					pass=plg_close(plg);
					if(pass==1)
					{
						printf("POLYGON CENTROID\n");
						printf("Xcoordinate=%lf Ycoordinate=%lf\n",plg_getxCentroid(plg),plg_getyCentroid(plg));
					}
					else
					{
						printf("This is not a polygon!\n");
					}
				}
				
				if(d==6)
				{	
					pass=plg_close(plg);
					if(pass==1)
					{
						printf("POLYGON TYPE\n");
						if(plg_isRegular(plg)==1)
						{
							printf("This is a regular polygon\n");
						
						}
						if(plg_isRegular(plg)==2)
						{
							printf("This is an irregular polygon\n");
							
						}
					}
					else
					{
						printf("This is not a polygon!\n");
					}
					
				}
				if(d==7)
				{
					printf("SHIFT HORIZONTALLY\n");
					printf("How many units do you wanted to shift:");
					scanf("%lf",&hor);
					fflush(stdin);
					plg_shiftHorizontally(plg,hor);
					poly_wfile = fopen(file1, "w");
					plg_write(plg,poly_wfile);
					printf("\nThe polygon is sucessfully shifted & writen onto txt file\n");
				
				}
				if(d==8)
				{
					printf("SHIFT VERTICALLY\n");
					printf("How many units do you wanted to shift:");
					scanf("%lf",&ver);
					fflush(stdin);
					plg_shiftVertically(plg,ver);
					poly_wfile = fopen(file1, "w");
					plg_write(plg,poly_wfile);
					printf("\nThe polygon is sucessfully shifted & writen onto txt file\n");
				}
				
				
				if(d==10||d==9)
				{
					escape=255;
				
				}
				
			
				
			}while(escape!=255);
			
		}
	}while(d!=10);
	printf("Thankyou for using this program\n");
	plg_delete(plg);
	
	fclose(poly_rfile);

return 0;
}


