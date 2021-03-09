*Simple demo to show creating SAS Report via a Git Clone;
ods _all_ close;
ods listing image_dpi=300;
filename odsout "/home/sasdemo/git/gssODS.html" mod;

*create new ODS output;

data _null_;
     file odsout;
     put '<html>';
     put '<HEAD>';
	 put '<center><img align="centre" src="https://www.sas.com/etc/designs/saswww/apple-touch-icon-152x152.png" style="width:152px;height:152px;"></img></center>';
     put '<TITLE>SAS Output</TITLE>';
	 put '<head><link rel="stylesheet" href="mystyle2.css"></head>';
     put '</HEAD>';
     put "<BODY class='body'>";
     put '<h1><center>Cars Report for GSS</h1>';
	 put '<p><center>This report shows an example of adding HTML output to ODS</p>';
   run;

ods html5 path = '/home/sasdemo/git' body=odsout(notop) options(svg_mode='inline') style=raven;

title 'Interactive Bar Plot';
ods graphics on / imagemap  noborder  outputfmt=svg; /* enable data tips */

*interactive bar plot;
proc sgplot data=sashelp.cars;
  vbar Make /
    response=MSRP
    stat=mean;
run;

title 'Interactive Scatter Plot Custom Part';
*insert scatter plot with tooltips;
proc sgplot data=Sashelp.Cars;
scatter x=Weight y=MPG_City;
run;
title;

*add table of means;
title 'Cross Table Report';
proc tabulate data=sashelp.cars f=dollar14.2;
class Make Type;
var MSRP;
table Make,Type*MSRP*mean;
run;
title;

ODS html5 CLOSE; 

filename odsout clear;