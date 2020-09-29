*Simple demo to show creating SAS Report via a Git Clone;

ods _all_ close;
ods listing image_dpi=300;

*create new ODS output;
ods html5 body='/home/sasdemo/git/demoGIT.htm'  options(svg_mode='inline') ;

title 'Interactive Bar Plot';
ods graphics on / imagemap  noborder  outputfmt=svg; /* enable data tips */

*interactive bar plot;
proc sgplot data=sashelp.cars;
  vbar Make /
    response=MSRP
    stat=mean;
run;

title 'Interactive Scatter Plot';
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

ODS HTML5 CLOSE; 