#!perl -w
# $Id: make_issues.pl,v 1.3 2004/09/30 16:09:27 jlinoff Exp $
# ================================================
# Copyright Notice
# Copyright (C) 1998-2004 by Joe Linoff (http://www.joelinoff.com)
# 
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
# 
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
# IN NO EVENT SHALL JOE LINOFF BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
# ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
# OTHER DEALINGS IN THE SOFTWARE.
# 
# Comments and suggestions are always welcome.
# ================================================
#
# Generate an HTML FAQ by parsing a text file
# with some embedded keywords.
#
# This script recognizes certain keywords.
#
# All keywords must start at the beginning of a line.
#
# Comments are delimited by # at the beginning of
# a line unless you are in a description subsection.
#
# The document contains two parts, the page section
# and the entry sections. The page section describes
# details about the document itself. The page keywords
# have the PAGE_ prefix.
#
# There is an entry section for each entry in the
# document. The entry keywords have the ENTRY_ prefix.
#
# Here is what an example document might look like
# with two entries.
#
#   # ========================
#   # This is an example list
#   # of issues.
#   # ========================
#   PAGE_TITLE: Example List
#   PAGE_AUTHOR: I.M. Author
#   PAGE_EMAIL: imauthor@mail.net
#   PAGE_REVISION: $Revision: 1.3 $
#   PAGE_DATE: $Date: 2004/09/30 16:09:27 $
#   PAGE_DESC_BEGIN:
#   This page keeps track of issues.
#   If is used for a variety of purposes.
#   PAGE_DESC_END:
#
#   # ========================
#   # Entry 0001
#   # ========================
#   ENTRY_ID: 0001
#   ENTRY_TITLE: There is a bug in the foo stuff.
#   ENTRY_REPORTED_BY: I.M. Author
#   ENTRY_REPORTED_ON: 2002/07/29
#   ENTRY_STATUS: FIXED
#   ENTRY_RESOLVED_BY: I.M Author
#   ENTRY_RESOLVED_ON: 2002/07/29
#   ENTRY_REPORTED_BEGIN:
#   There is a bug.
#   ENTRY_REPORTED_END:
#   ENTRY_RESOLVED_BEGIN:
#   It was fixed in release 10.
#   ENTRY_RESOLVED_END:
#
#   # ========================
#   # Entry 0002
#   # ========================
#   ENTRY_ID: 0002
#   ENTRY_TITLE: There is another bug in the foo stuff.
#   ENTRY_REPORTED_BY: I.M. Author
#   ENTRY_REPORTED_ON: 2002/07/29
#   ENTRY_STATUS: OPEN
#   ENTRY_RESOLVED_BY:
#   ENTRY_RESOLVED_ON:
#   ENTRY_REPORTED_BEGIN:
#   There is another bug.
#   ENTRY_REPORTED_END:
#   ENTRY_RESOLVED_BEGIN:
#   ENTRY_RESOLVED_END:
#
# The keywords are described in more detail in the following
# sections.
#
# ================================================
# PAGE_TITLE: <title>
#
#    The title of the page. The keyword and data must exist on one
#    line.
#
#    Here is a usage example:
#       PAGE_TITLE: <a href="http://foobar.com">The Title</a>
#
#    Note that the FAQER will strip out the HTML tags for the page
#    <title></title> entry so that wierd stuff will not show up at the
#    top of the browser window.
#
# ================================================
# PAGE_AUTHOR: <name>
#
#    The author of the page. The keyword and data must exist on one
#    line.
#
#    Here is a sample usage:
#       PAGE_AUTHOR: Joe Linoff
#
# ================================================
# PAGE_EMAIL: <email address>
#
#    The e-mail address of the author. The keyword and data must
#    exist on one line.
#
#    Here is a sample usage:
#       PAGE_EMAIL: jdl@xilinx.com
#
# ================================================
# PAGE_REVISION: <date>
#
#    The page revision.  The keyword and data must exist on one
#    line.
#
#    Here is a sample usage:
#       PAGE_REVISION: $Revision: 1.3 $
#
# ================================================
# PAGE_DATE: <date>
#
#    The Date this page was generated. The keyword and data must
#    exist on one line.
#
#    Here is a sample usage:
#       PAGE_DATE: $Date: 2004/09/30 16:09:27 $
#
# ================================================
# PAGE_DESC_BEGIN:
# <lines>
# PAGE_DESC_END:
#
#    A description of the title page.
#
#    The desccription can contain any text, including HTML.
#    Remember that if you want <,> or & characters
#    you must use &lt;, &gt; or &amp;
#
#    Here is an example usage:
#       PAGE_DESC_BEGIN:
#       This is a the page of issues.
#       PAGE_DESC_END:
#
# ================================================
# ENTRY_ID: <id>
#
#    This describes a unique entry id. I use numbers but this can be
#    anything. The script verifies that each entry id is unique. The
#    keyword and data must exist on one line.
#
#    Here is an example usage:
#       ENTRY_ID: 0001
#
# ================================================
# ENTRY_TITLE: <title>
#
#    This describes the entry title. The keyword and data must exist
#    on one line.
#
#    Here is an example usage:
#       ENTRY_TITLE: Core dump in foo when -aa 100 is specified.
#
# ================================================
# ENTRY_REPORTED_BY: <name>
#
#    This describes the author of the entry. This is usually
#    the person who reported it. I sometimes embed the
#    the email information. The keyword and data must exist
#    on one line.
#
#    Here is an example usage:
#       ENTRY_REPORTED_BY: <a href="mailto:jdl@xilinx.com">Joe</a>
#
# ================================================
# ENTRY_REPORTED_ON: <date>
#
#    This describes the date that the entry was reported.  The keyword
#    and data must exist on one line.
#
#    Here is an example usage:
#       ENTRY_REPORTED_BY: <a href="mailto:jdl@xilinx.com">Joe</a>
#
# ================================================
# ENTRY_STATUS: <string>
#
#    The entry status. The user can specify any string but it is best
#    if it has no white space because it is used to generate
#    additional HTML files. I typically use statuses like: OPEN,
#    FIXED, CLOSED, PENDING.  When the script runs it groups entries
#    based on the status string (the entries are case sensitive) and
#    generates HTML files with names like issues_OPEN.html and
#    issues_FIXED.html. I use upper case to avoid problems. The
#    keyword and data must exist on one line.
#
#    Here is an example usage:
#       ENTRY_STATUS: OPEN
#
# ================================================
# ENTRY_RESOLVED_BY: <name>
#
#    This describes the author of the entry. This is usually
#    the person who resolved it. I sometimes embed the
#    the email information. The keyword and data must exist
#    on one line.
#
#    Here is an example usage:
#       ENTRY_RESOLVED_BY: <a href="mailto:jdl@xilinx.com">Joe</a>
#
# ================================================
# ENTRY_RESOLVED_ON: <date>
#
#    This describes the date that the entry was resolved.  The keyword
#    and data must exist on one line.
#
#    Here is an example usage:
#       ENTRY_RESOLVED_BY: <a href="mailto:jdl@xilinx.com">Joe</a>
#
# ================================================
# ENTRY_REPORTED_BEGIN:
# <lines>
# ENTRY_REPORTED_END:
#
#    A description of the entry.
#
#    The desccription can contain any text, including HTML.
#    Remember that if you want <,> or & characters
#    you must use &lt;, &gt; or &amp;
#
#    Here is an example usage:
#       ENTRY_REPORTED_BEGIN:
#       There is a problem.
#       ENTRY_REPORTED_END:
#
# ================================================
# ENTRY_RESOLVED_BEGIN:
# <lines>
# ENTRY_RESOLVED_END:
#
#    A description of the resolution.
#
#    The desccription can contain any text, including HTML.
#    Remember that if you want <,> or & characters
#    you must use &lt;, &gt; or &amp;
#
#    Here is an example usage:
#       ENTRY_RESOLVED_BEGIN:
#       This entry was resolved by fixing the problem.
#       ENTRY_RESOLVED_END:
#
#
use strict;

&Main;

# ================================================================
# MAIN
# ================================================================
sub Main
{
    my $ifile = "";
    my $ofile = "";
    my $verbose = 0;
    while ( $#ARGV>=0 ) {
	my $arg = shift @ARGV;
	if ( $arg eq "-i" ) {
	    $ifile = shift @ARGV;
	    next;
	}
	if ( $arg eq "-o" ) {
	    $ofile = shift @ARGV;
	    next;
	}
	if ( $arg eq "-h" ) {
	    &Usage;
	}
	if ( $arg eq "-v" ) {
	    $verbose = 1;
	    next;
	}
	print STDERR "ERROR: Unrecognized switch '$arg'.\n";
	&Usage;
    }
    if ( $ifile eq "" ) {
	print STDERR "ERROR: -i <file> not specified.\n";
	&Usage;
    }
    if ( $ofile eq "" ) {
	print STDERR "ERROR: -o <file> not specified.\n";
	&Usage;
    }
    &Process($ifile,$ofile);
}
# ================================================================
# Process the data and create the HTML output.
# ================================================================
sub Process
{
    my $ifile = shift;
    my $ofile = shift;

    # ================================================
    # Set the default page records.
    # ================================================
    my %page = ();
    $page{"title"} = "Unknown";
    $page{"author"} = "Unknown";
    $page{"email"} = "";
    $page{"revision"} = "Unknown";
    $page{"date"} = "Unknown";
    $page{"description"} = "Unknown";

    # ================================================
    # Process the input file.
    # ================================================
    my %entry = ();
    my %status = ();
    my $num_entries = 0;
    my $entryid = "";
    my $err = 0;
    my $lineno = 1;
    open(IFILE,"$ifile") || die "ERROR: Can't read '$ifile'.\n";
    while(<IFILE>) {
	$lineno++;
	chop;
	my $line = $_;
	if ( $line =~ /^PAGE_TITLE:\s+(.*)$/ ) {
	    $page{"title"} = $1;
	    next;
	}
	if ( $line =~ /^PAGE_AUTHOR:\s+(.*)$/ ) {
	    $page{"author"} = $1;
	    next;
	}
	if ( $line =~ /^PAGE_EMAIL:\s+(.*)$/ ) {
	    $page{"email"} = $1;
	    next;
	}
	if ( $line =~ /^PAGE_REVISION:\s+(.*)$/ ) {
	    $page{"revision"} = $1;
	    next;
	}
	if ( $line =~ /^PAGE_DATE:\s+(.*)$/ ) {
	    $page{"date"} = $1;
	    next;
	}
	if ( $line =~ /^PAGE_DESC_BEGIN:\s*$/ ) {
	    my $desc = "";
	    while(<IFILE>) {
		chop;
		$line = $_;
		last if ( $line =~ /^PAGE_DESC_END:\s*$/ );
		$desc = "$desc\n$line";
	    }
	    $page{"description"} = $desc;
	    next;
	}
	if ( $line =~ /^ENTRY_ID:\s+(.*)$/ ) {
	    $num_entries++;
	    $entryid = $1;
	    if ( defined $entry{$entryid} ) {
		print STDERR "ERROR: Duplicate entry id '$entryid' found at line $lineno.\n";
		$err++;
	    }
	    $entry{$entryid}{"title"} = "";
	    $entry{$entryid}{"reported_by"} = "";
	    $entry{$entryid}{"reported_on"} = "";
	    $entry{$entryid}{"reported_description"} = "";
	    $entry{$entryid}{"status"} = "";
	    $entry{$entryid}{"resolved_by"} = "";
	    $entry{$entryid}{"resolved_on"} = "";
	    $entry{$entryid}{"resolved_description"} = "";
	    next;
	}
	if ( $line =~ /^ENTRY_TITLE:\s+(.*)$/ ) {
	    $entry{$entryid}{"title"} = $1;
	    next;
	}
	if ( $line =~ /^ENTRY_REPORTED_BY:\s+(.*)$/ ) {
	    $entry{$entryid}{"reported_by"} = $1;
	    next;
	}
	if ( $line =~ /^ENTRY_REPORTED_ON:\s+(.*)$/ ) {
	    $entry{$entryid}{"reported_on"} = $1;
	    next;
	}
	if ( $line =~ /^ENTRY_STATUS:\s*(.*)$/ ) {
	    $entry{$entryid}{"status"} = $1;
	    if ( $1 ne "" ) {
		if ( ! defined( $status{$1} ) ) {
		    $status{$1} = 0;
		}
		my $x = $status{$1};
		my $y = $x + 1;
		$status{$1} = $y;
	    }
	    next;
	}
	if ( $line =~ /^ENTRY_RESOLVED_BY:\s*(.*)$/ ) {
	    $entry{$entryid}{"resolved_by"} = $1;
	    next;
	}
	if ( $line =~ /^ENTRY_RESOLVED_ON:\s*(.*)$/ ) {
	    $entry{$entryid}{"resolved_on"} = $1;
	    next;
	}
	if ( $line =~ /^ENTRY_REPORTED_BEGIN:\s*$/ ) {
	    my $desc = "";
	    while(<IFILE>) {
		chop;
		$line = $_;
		last if ( $line =~ /^ENTRY_REPORTED_END:\s*$/ );
		if ( $line =~ /^ENTRY_LINK:\s*(\S*)\s+(.*)$/ ) {
		    # ENTRY_LINK: <id> <desc>
		    $desc = "$desc\n<a href=#TAG_$1>$2</a>";
		}
		else {
		    $desc = "$desc\n$line";
		}
	    }
	    $entry{$entryid}{"reported_description"} = $desc;
	    next;
	}
	if ( $line =~ /^ENTRY_RESOLVED_BEGIN:\s*$/ ) {
	    my $desc = "";
	    while(<IFILE>) {
		chop;
		$line = $_;
		last if ( $line =~ /^ENTRY_RESOLVED_END:\s*$/ );
		if ( $line =~ /^ENTRY_LINK:\s*(\S*)\s+(.*)$/ ) {
		    # ENTRY_LINK: <id> <desc>
		    $desc = "$desc\n<a href=#TAG_$1>$2</a>";
		}
		else {
		    $desc = "$desc\n$line";
		}
	    }
	    $entry{$entryid}{"resolved_description"} = $desc;
	    next;
	}
	if ( $line =~ /^(ENTRY\S+:)/ ) {
	    print STDERR "ERROR: Unrecognized token '$1' at line $lineno\n";
	    $err++;
	    next;
	}
	if ( $line =~ /^(PAGE\S+:)/ ) {
	    print STDERR "ERROR: Unrecognized token '$1' at line $lineno\n";
	    $err++;
	    next;
	}
    }
    close(IFILE);

    exit $err if ( $err );

    # ================================================
    # Write the master page.
    # ================================================
    my @tokens = split(/\./,$ofile);
    my $rootfn = $tokens[0];
    my $rootext = $tokens[1];
    my $sumfile = "${rootfn}-summary.html";
    print "Creating $ofile ...\n";
    open(OFILE,">$ofile") || die "ERROR: Can't write '$ofile'.\n";
    # Create the header
    &PrintHtmlHeader(\*OFILE,
		     "$page{title}",
		     "All",
		     "$page{author}",
		     "$page{date}",
		     "$page{revision}",
		     "Summary",
		     "$sumfile");
    print OFILE "$page{description}\n";
    # Create the summary table.
    &PrintHtmlStatusTable(\*OFILE,
			  \%status,
			  $num_entries,
			  $ofile,
			  "$rootfn",
			  "$rootext");
    # entry summary table
    &PrintHtmlEntrySummaryTable(\*OFILE,
				\%entry,
				"all",
				"");
    # Entries
    &PrintHtmlEntries(\*OFILE,
		      \%entry,
		      "all");
    # End of the file.
    &PrintHtmlTrailer(\*OFILE,
		      "$page{email}",
		      "$page{author}",
		      "$page{date}");
    # write the master output file.
    close OFILE;

    # ================================================
    # Write the summary page.
    # ================================================
    print "Creating $sumfile ...\n";
    open(OFILE,">$sumfile") || die "ERROR: Can't write '$sumfile'.\n";
    # Create the header
    &PrintHtmlHeader(\*OFILE,
		     "$page{title}",
		     "Summary",
		     "$page{author}",
		     "$page{date}",
		     "$page{revision}",
		     "All",
		     "$ofile");
    # Create the summary table.
    &PrintHtmlStatusTable(\*OFILE,
			  \%status,
			  $num_entries,
			  $sumfile,
			  "$rootfn",
			  "$rootext");
    # entry summary table
    &PrintHtmlEntrySummaryTable(\*OFILE,
				\%entry,
				"all",
				"$tokens[0].html");
    # End of the file.
    &PrintHtmlTrailer(\*OFILE,
		      "$page{email}",
		      "$page{author}",
		      "$page{date}");
    # write the master output file.
    close OFILE;

    # ================================================
    # Write pages for each status.
    # ================================================
    my $key;
    foreach $key ( sort keys %status ) {
	my $fn = "${rootfn}_$key.${rootext}";
	print "Creating $fn ...\n";
	open(OFILE,">$fn") || die "ERROR: Can't write '$fn'.\n";
	# Create the header
	&PrintHtmlHeader(\*OFILE,
			 "$page{title}",
			 "$key Status",
			 "$page{author}",
			 "$page{date}",
			 "$page{revision}",
			 "All",
			 $ofile,
			 "$rootfn",
			 "$rootext");
	# entry summary table
	&PrintHtmlEntrySummaryTable(\*OFILE,
				    \%entry,
				    $key,
				    "");
	# Entries
	&PrintHtmlEntries(\*OFILE,
			  \%entry,
			  $key);
	# End of the file.
	&PrintHtmlTrailer(\*OFILE,
			  "$page{email}",
			  "$page{author}",
			  "$page{date}");
	# write the master output file.
	close OFILE;
    }
}
# ================================================================
# Print the header
# ================================================================
sub PrintHtmlHeader
{
    my $out = shift;
    my $title = shift;
    my $subtitle = shift;
    my $author = shift;
    my $date = shift;
    my $revision = shift;
    my $link = shift;
    my $href = shift;
    
    print $out "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 3.2//EN\">\n";
    print $out "<!-- Subroutine: PrintHtmlHeader -->\n";
    print $out "<html>\n";
    print $out "<head>\n";

    if( $title =~ /\<\/a>/ ) {
	# Strip out the formatting tags for the title.
	my $tmp = $title;
	while ( $tmp =~ /<[^>]+>/ ) {
	    $tmp =~ s/<[^>]+>/ /g;
	}
	print $out "<title>${tmp}</title>\n";
    }
    else {
	print $out "<title>${title}</title>\n";
    }

    print $out "<meta http-equiv=\"Content-Type\" content=\"text/html; charset=iso-8859-1\">\n";
    print $out "</head>\n";
    print $out "<body bgcolor=white>\n";
    print $out "<a name=top></a>\n";
    print $out "<center>\n";

    print $out "<font size=\"+2\"><b>${title}</b></font>";
    print $out "<br><font size=\"+2\"><b>${subtitle}</b></font>";
    if( $link ne "" && $href ne "" ) {
	print $out "<br><b><a href=\"${href}\">${link}</a></b>\n";
    }

    print $out "<br>\n";
    print $out "${author}\n";
    print $out "<br>\n";
    print $out "${date}\n";
    print $out "<br>\n";
    print $out "<font size=\"-1\">${revision}</font>\n";
    print $out "</center>\n";
}
# ================================================================
# Print the header
# ================================================================
sub PrintHtmlTrailer
{
    my $out = shift;
    my $email = shift;
    my $author = shift;
    my $date = shift;

    print $out "<!-- Subroutine: PrintHtmlTrailer -->\n";
    print $out "<hr noshade width=\"100%\" size=2>\n";
    print $out "<center>\n";
    print $out "<font size=\"-1\">\n";
    print $out "<a href=\"#top\">[Top]</a>\n";
    print $out "<br>\n";
    print $out "This page is maintained by <a href=\"mailto:${email}\">${author}</a>.\n";
    print $out "<br>\n";
    print $out "Last updated: ${date}\n";
    print $out "<br>\n";
    print $out "<br>\n";
    print $out "<i>This page was automatically generated by issues.pl.</i>\n";
    print $out "</font>\n";
    print $out "</center>\n";
    print $out "</body>\n";
    print $out "</html>\n";
}
# ================================================================
# Status summary table.
# ================================================================
sub PrintHtmlStatusTable
{
    my $out = shift;
    my $ht = shift;
    my $num_entries = shift;
    my $ofile = shift;
    my $rootfn = shift;
    my $rootext = shift;

    my %status = %$ht;
    my $key;

    print $out "<!-- Subroutine: PrintHtmlStatusTable -->\n";
    print $out "<hr noshade width=\"100%\" size=2>\n";
    print $out "<center>\n";
    print $out "<font size=\"+1\">Status Summary</font><br>\n";
    print $out "<table border=1>\n";
    print $out "<tr>\n";
    print $out "<th>Status\n";
    print $out "<th>Number\n";
    foreach $key ( sort keys %status ) {
	my $fn = "${rootfn}_$key.${rootext}";
	print $out "</tr>\n";
	print $out "<tr>\n";
	print $out "<td><a href=\"$fn\">$key</a></td>\n";
	print $out "<td align=right>$status{$key}</td>\n";
    }
    print $out "</tr>\n";
    print $out "<tr>\n";
    print $out "<td><b>Total</b></td>\n";
    print $out "<td align=right>$num_entries</td>\n";
    print $out "</tr>\n";
    print $out "</table>\n";
    print $out "</center>\n";
}
# ================================================================
# Entry summary table.
# ================================================================
sub PrintHtmlEntrySummaryTable
{
    my $out = shift;
    my $ht = shift;
    my $match = shift;
    my $href_prefix = shift;

    my %entry = %$ht;
    my $key;

    print $out "<!-- Subroutine: PrintHtmlEntrySummaryTable -->\n";
    print $out "<a name=summary></a>\n";
    print $out "<hr noshade width=\"100%\" size=2>\n";
    print $out "<center>\n";
    print $out "<font size=\"+1\">Entry Summary</font><br>\n";
    print $out "<table border=1>\n";
    print $out "<tr>\n";
    print $out "<th>Id\n";
    print $out "<th>Title\n";
    print $out "<th>Status\n";
    foreach $key ( sort keys %entry ) {
	my $status = $entry{$key}{status};
	next if( $status ne $match && $match ne "all" );
	print $out "</tr>\n";
	print $out "<tr>\n";
	print $out "<td><a href=\"${href_prefix}#TAG_$key\">$key</a></td>\n";
	print $out "<td>$entry{$key}{title}</td>\n";
	print $out "<td>$entry{$key}{status}</td>\n";
    }
    print $out "</tr>\n";
    print $out "</table>\n";
    print $out "</center>\n";
}
# ================================================================
# Entries
# ================================================================
sub PrintHtmlEntries
{
    my $out = shift;
    my $ht = shift;
    my $match = shift;

    my %entry = %$ht;
    my $key;
    my @xkeys = sort keys %entry;
    my @keys = ();
    foreach $key ( @xkeys ) {
	my $status = $entry{$key}{status};
	next if( $status ne $match && $match ne "all" );
	push @keys,$key;
    }
    my $previous = "";
    my $next = "";
    my $i = 0;
    foreach $key ( @keys ) {
	$i++;
	$previous = "";
	$previous = $keys[$i-2] if($i-2>=0);
	$next = "";
	$next = $keys[$i] if($i<=$#keys);
	&PrintHtmlEntry($out,$ht,$key,$next,$previous);
    }
}
# ================================================================
# Entries
# ================================================================
sub PrintHtmlEntry
{
    my $out = shift;
    my $ht = shift;
    my $key = shift;
    my $next = shift;
    my $previous = shift;

    my %entry = %$ht;

    print $out "<!-- Subroutine: PrintHtmlEntry -->\n";
    print $out "<a name=TAG_$key></a>\n";
    print $out "<hr noshade width=\"100%\" size=2>\n";

    print $out "<table width=\"100%\"  border=0 cellspacing=0 cellpadding=0>\n";
    print $out "<tr valign=top>\n";
    print $out "<td>\n";

    print $out "<table border=0 cellspacing=0 cellpadding=0>\n";
    print $out "<tr><td><b>Title: </b></td><td>$entry{$key}{title}</td></tr>\n";
    print $out "<tr><td><b>Status: </b></td><td>$entry{$key}{status}</td></tr>\n";
    print $out "<tr><td><b>Reported By: </b></td><td>$entry{$key}{reported_by}</td></tr>\n";
    print $out "<tr><td><b>Reported On: </b></td><td>$entry{$key}{reported_on}</td></tr>\n";
    print $out "<tr><td><b>Resolved By: </b></td><td>$entry{$key}{resolved_by}</td></tr>\n";
    print $out "<tr><td><b>Resolved On: </b></td><td>$entry{$key}{resolved_on}</td></tr>\n";
    print $out "</table>\n";
    print $out "</td>\n";

    print $out "<td align=right>\n";
    print $out "<b>Id: </b>$key\n";
    print $out "<br>\n";
    print $out "<font size=\"-1\"><a href=\"#top\">[Top]</a></font>\n";
    print $out "<br>\n";
    print $out "<font size=\"-1\"><a href=\"#summary\">[Summary]</a></font>\n";
    if ( $next ne "" ) {
	print $out "<br>\n";
	print $out "<font size=\"-1\"><a href=\"#TAG_$next\">[Next]</a></font>\n";
    }
    if ( $previous ne "" ) {
	print $out "<br>\n";
	print $out "<font size=\"-1\"><a href=\"#TAG_$previous\">[Previous]</a></font>\n";
    }

    print $out "</td>\n";
    print $out "</tr>\n";
    print $out "</table>";

    print $out "<b>Problem Description: </b>\n";
    print $out "<blockquote>\n";
    print $out "$entry{$key}{reported_description}\n";
    print $out "</blockquote>\n";

    print $out "<b>Solution Description: </b>\n";
    print $out "<blockquote>\n";
    print $out "$entry{$key}{resolved_description}\n";
    print $out "</blockquote>\n";
}
# ================================================================
# Report the usage and exit.
# ================================================================
sub Usage
{
    my $rev = '$Id: make_issues.pl,v 1.3 2004/09/30 16:09:27 jlinoff Exp $'; #'
    print STDERR "\n";
    print STDERR "$rev\n";
    print STDERR "\n";
    print STDERR "usage: perl issues.pl [args]\n";
    print STDERR "\n";
    print STDERR "  -h         On-line help.\n";
    print STDERR "  -i <file>  The input file\n";
    print STDERR "  -o <file>  The output HTML file\n";
    print STDERR "  -v         Verbose mode.\n";
    print STDERR "\n";

    exit 0;
}
