#include <stdlib.h>
#include <math.h>
#include <stdio.h>
#include <malloc.h>
#include "Polygon.h.h"

Polygon *plg_new(double *xCoord, double *yCoord,int numberOfVertices)
{
	int i;
	Polygon * newplg = (Polygon*) malloc(sizeof(Polygon));
	
	
	newplg->xCoordinates = malloc((numberOfVertices)*sizeof(double));
	

	if(newplg->xCoordinates != NULL)
	{
		for(i = 0; i < numberOfVertices; i++)
		{
			newplg->xCoordinates[i] = xCoord[i];
		
		}
	}
	newplg->yCoordinates = malloc((numberOfVertices)*sizeof(double));
	
	if(newplg->xCoordinates != NULL)
	{
		for(i = 0; i <numberOfVertices; i++)
		{
			newplg->yCoordinates[i] = yCoord[i];
		
		}
	}	 
		newplg->numberOfVertices = numberOfVertices;
	
	return newplg; 	      
}

void plg_delete(Polygon *plg)
{
	if(plg != NULL)
	{
		free(plg->xCoordinates);
		free(plg->yCoordinates);
		free(plg);
	}
}

Polygon *plg_read(Polygon *plg, FILE *plg_rfile)
{
	
	double *xCoord;
	double *yCoord;
	double xhold;
	double yhold;
	int numOfVertices=0;
	
	while(!feof(plg_rfile))
	{
		fscanf(plg_rfile, "%lf %lf\n", &xhold,&yhold);
		numOfVertices++;	
	}
	
	xCoord = malloc((numOfVertices) * sizeof(double));
	yCoord = malloc((numOfVertices) * sizeof(double));
		
	numOfVertices=0;	
	rewind(plg_rfile);  	
while(!feof(plg_rfile))
		{		
		
				fscanf(plg_rfile,"%lf %lf\n",&xCoord[numOfVertices],&yCoord[numOfVertices]);
				
				numOfVertices++;
		}
	
	
	
	
	plg = plg_new(xCoord,yCoord,numOfVertices);
	
	fclose(plg_rfile); 
	return plg;

	
}

void plg_write(Polygon *plg, FILE *plg_wfile)
{	int i;
	
	
		
		for(i=0;i<plg->numberOfVertices;i++)
			{
				 fprintf(plg_wfile,"%lf %lf\n",plg->xCoordinates[i],plg->yCoordinates[i]);
			}
		printf("successful write\n");
	fclose(plg_wfile);
	
} 

double plg_getArea(Polygon *plg)
{
	int i;
	double sumX=0.0;
	double sumY=0.0;
	double Area=0.0;
	
	for(i = 0; i < plg->numberOfVertices; i++)
	{
		sumX += (plg->xCoordinates[i] * plg->yCoordinates[i+1]);
		
	}
	sumX += (plg->xCoordinates[plg->numberOfVertices-1] * plg->yCoordinates[0]);
	
	
	for(i = 0; i<plg->numberOfVertices; i++)
	{
		sumY += (plg->yCoordinates[i] * plg->xCoordinates[i+1]);
		
	}
	sumY += (plg->yCoordinates[plg->numberOfVertices-1] * plg->xCoordinates[0]);
	
	Area = (sumX - sumY) / 2.0;
	
	if (Area<0)
	{
		Area= Area*-1;
	
	}
	
	return Area;  
}

double plg_getPerimeter(Polygon *plg)
{
	int i=0;
	double *psum;
	double pmeter=0.0;
	
	psum= malloc((plg->numberOfVertices)*sizeof(double));
	
	for(i = 0; i < plg->numberOfVertices-1; i++)
	{
		psum[i] = sqrt(pow(plg->xCoordinates[i+1]-plg->xCoordinates[i],2) + pow(plg->yCoordinates[i+1]-plg->yCoordinates[i],2));
	
	}
	
	for(i = 0; i < plg->numberOfVertices-1; i++)
	{
		pmeter += psum[i];
	
	}
	
	free(psum);
	return pmeter;
}
double plg_close(Polygon *plg)
{
	int i=0;
	int pass;

	
		if (plg->xCoordinates[plg->numberOfVertices-1]==plg->xCoordinates[0]&&plg->yCoordinates[plg->numberOfVertices-1]==plg->yCoordinates[0])
							{
								pass=1;
								return pass;
							}
						else
							{
								pass = 2;
								return pass;
							}	   

	

}

double plg_getxCentroid(Polygon *plg)
{
	int i;
	double xcoorsum=0.0;
	
	
	for(i = 0; i < plg->numberOfVertices-1; i++)
	{
		xcoorsum += plg->xCoordinates[i];
	
	}
	
	return (xcoorsum/(plg->numberOfVertices-1));
}

double plg_getyCentroid(Polygon *plg)
{
	int i;
	double ycoorsum=0.0;
	
	for(i = 0; i < plg->numberOfVertices-1; i++)
	{
		ycoorsum += plg->yCoordinates[i];
	
	}
	
	return (ycoorsum/(plg->numberOfVertices-1));
}

double plg_isRegular(Polygon *plg)
{
	int i=0;
	double *unit;
	int hold;
	int mode=0;
	
	unit= malloc((plg->numberOfVertices)*sizeof(double));
	
	for(i = 0; i < plg->numberOfVertices-1; i++)
	{
		unit[i] = sqrt(pow(plg->xCoordinates[i+1]-plg->xCoordinates[i],2) + pow(plg->yCoordinates[i+1]-plg->yCoordinates[i],2));
	
	}
	
	for(i = 0; i < plg->numberOfVertices-2; i++)
	{
		if(unit[i]==unit[i+1])
		{
			hold++;
		}
	
	}
	
	if(hold==plg->numberOfVertices-2)
	{
		mode=1;
		return mode;
	}
	
	else
	{
		mode=2;
		return mode;
	}
	
	free(unit);
	
}

void plg_shiftHorizontally(Polygon * plg, double hor)
{
	int i;
	
	for(i=0; i<plg->numberOfVertices;i++)
	{
		plg->xCoordinates[i] = plg->xCoordinates[i] + hor;
	}
}

void plg_shiftVertically(Polygon * plg, double ver)
{
	int i;
	
	for(i=0; i<plg->numberOfVertices;i++)
	{
		plg->yCoordinates[i] = plg->yCoordinates[i] + ver;
	}
}
		  

