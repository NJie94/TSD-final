/**
 * Copyright 2003 (c)
 * Dreamers Incorporated is a company that sells software
 * packages that make programming easier.
 * Our premier software package is the hello_world library
 * that allows programmers in all walks of life to generate
 * the hello world output in their own custom programs.
 * @author I.M. Adreamer
 * @version $Id: hello_world.h,v 1.2 2003/02/26 18:45:47 jlinoff Exp $
 * @pkgdoc @root
 */

#ifndef hello_world_h
#define hello_world_h

/**
 * The hello_world namespace associates all of
 * the services related to the hello_world package.
 * This package exists to help programmers all over
 * the world output the standard "Hello, world!"
 * with minimal effort.
 * @author I.M. Adreamer
 * @version $Id: hello_world.h,v 1.2 2003/02/26 18:45:47 jlinoff Exp $
 */
namespace hello_world {
   /**
    * Say "Hello, world!" to the world.
    * The example below shows how to use this function:
    *<blockquote>
    *<pre>
    *@@ #include "hello_world.h"
    *@@ int main(int,char**) {
    *@@    hello_world::hi();
    *@@ }
    *</pre>
    *</blockquote>
    * @param os The output stream.
    * @author I.M. Aprogrammer
    * @version $Id: hello_world.h,v 1.2 2003/02/26 18:45:47 jlinoff Exp $
    */
   void hi(ostream& os = cout);
}

#endif
