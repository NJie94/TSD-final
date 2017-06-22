
/**
 * Module Polygon.h.h    
 *  
 * Implements a medley of useful functions 
 * 
 * @author  HI KAI JIE
 * @version 2.1 12/05/14
 */
 

/**
 * Polygon structure initialize structure with parameters of numberOfVertices,xCoordinates,yCoordinates.
 * 
 * @param xCoordinates -is a pointer for x coordinates point in the structure
 * @param yCoordinates - a pointer for y coordinates of points in the structure
 */
typedef struct 
{
     int numberOfVertices;
	 double *xCoordinates;
     double *yCoordinates;
} Polygon;

/* function prototypes */
/**
 * plg_new Allocates memory to create a new Polygon and initialize the x and y coordinates in the Polygon. Returns the Polygon which created.
 * 
 * @param xCoordinates[] -is an array for x coordinates point
 * @param yCoordinates[] - an array for y coordinates of points
 * @return a pointer of new Polygon created
 */
Polygon *plg_new(double *xCoord, double *yCoord,int numberOfVertices);


/**
 * plg_delete Frees up memory allocated by the Polygon then passess into this function
 * @param plg - a Polygon struct pointer
 */
void plg_delete(Polygon *plg);


/**
 * plg_read accepts a Polygon and a file as parameters.
 * this reads the polygon point data from the file, and then pass the data 
 * @param plg -polygon struct
 *
 * @return  Polygon which new polygon created 
 */
Polygon *plg_read(Polygon *plg, FILE *plg_rfile);


/**
 * plg_write accepts a Polygon and a file as parameters
 * plg_write write data to the file, plgfile from the polygon plg
 * @param plg - a Polygon struct
 */
void plg_write(Polygon *plg, FILE *plg_wfile);


/**
 * plg_getArea accepts polygon as a parameter
 * reads input of data 
 * calculate and returns the area of a Polygon
 * @param plg - a Polygon struct
 * @return a double - the area of the Polygon
 */
double plg_getArea(Polygon *plg);

/**
 * plg_getPerimeter accepts polygon as a parameter
 * Allocate memory for perimeter 
 * calculate and returns the perimeter of a Polygon
 * @param plg - a Polygon struct
 * @return a double - the perimeter of the Polygon
 */
double plg_getPerimeter(Polygon *plg);

/**
 * plg_isRegular accepts polygon as a parameter
 * Allocate memory for units
 * By comparing the unit length of each side
 * @param plg - a Polygon struct
 * @return a integer - the case 1 or 2 of the Polygon belongs
 */

double plg_isRegular(Polygon *plg);


/**
 * plg_close accepts polygon as a parameter
 * Check if polygon are close or not
 * by checking the first coordinate with last coordinate
 * @param plg - a Polygon struct
 * @return a int - the value indicate close of the Polygon
 */
double plg_close(Polygon *plg);

/**
 * plg_getxCentroid accepts polygon as a parameter
 * Calculate the centroid of the xcoordinate
 * @param plg - a Polygon struct
 * @return a double - the xcoordinate of the Polygon
 */
double plg_getxCentroid(Polygon *plg);

/**
 * plg_getyCentroid accepts polygon as a parameter
 * Calculate the centroid of the ycoordinate
 * @param plg - a Polygon struct
 * @return a double - the ycoordinate of the Polygon
 */
double plg_getyCentroid(Polygon *plg);



/**
 * plg_shiftHorizontally accepts polygon as a parameter & initiallize horizontal of polygon shifted
 * Calculate by adding each horizontal unit into each coordinates
 * @param plg - a Polygon struct
 * @param double - number of horizontal shifted
 */
void plg_shiftHorizontally(Polygon * plg, double hor);

/**
 * plg_shiftVertically accepts polygon as a parameter & initiallize vertically of polygon shifted
 * Calculate by adding each vertically unit into each coordinates
 * @param plg - a Polygon struct
 * @param double - number of horizontal shifted
 */
void plg_shiftVertically(Polygon * plg, double ver);

