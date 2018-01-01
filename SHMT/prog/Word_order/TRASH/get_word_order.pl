#!PERLPATH

my $head = qq{
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!-- <script type="text/javascript" src="js/jquery.min.js"></script> -->
<meta http-equiv="CONTENT-TYPE" content="text/html; charset=utf-8" />
<meta name ="keywords" content="india,indology,sanskrit,lexicography,linguistics,computational linguistics,tools, morph analyser" />
<meta name ="date" content="2011-10-5" />
<meta name="classification" content="computational linguistics, sanskrit, morphology, lexicography, indology" />
<meta name="description" content="This site provides tools for Analysis of Sanskrit processing: morphological analysis and generation, segmentation, sandhi splitter, and parsing." />


<head>
<!-- All javascripts links for all modules -->
<title> Sanskrit Hindi Machine Translation (Anusaaraka) </title>
</head>

<body>
<div id="container">
<center>
<div id="project-name">
<img src="../../../imgs/sktmt.jpg" alt="anusaaraka logo" /> 
    </div>
</div> <!-- project name div ends here-->
</center>

<div> 
<table width="100%"><tr>
<td width="80%"><h3><a href="SCLURL/index.html"><font color="DarkBlue">संसाधनी-Saṃsādhanī</font></a></h3></td><td text-align="center" width="20%"><font color="magenta" size="3">10th Apr 2017</font></td><td text-align="right">  </td></tr></table>
</div>

<div> 
<form name="word-order" method="post" action="CGIURL/SHMT/prog/Word-order/call_heritage2anu.cgi">

<br />
<font color="green">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Verse order: </font> 
<font color="blue">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
};

my $tail = qq{
<br />
<br />
<font color="green">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Prose order: </font>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<textarea name="word-order" cols="50" rows="1" placeholder="Rearrange the words in anvaya order"></textarea> 
<br />
<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input type="submit" value="Submit" />
</div>

</form>
</div> 

<div id="line"> &nbsp; </div>
<div id="copy">
<center>
<table>
<tr>
<br />
<br />
<br />
<br />
<br />
<br />
<td id="copy-verify">
<p>
    <a href="http://validator.w3.org/check?uri=referer"><img
        src="SCLURL/imgs/w3c.jpg"
        alt="Valid XHTML 1.0 Transitional" height="31" width="" style="border-style:none;" /></a>
  </p>
</td>
<td id="copy-info">
<p> <span class="cons">© 2002-17 <a href="DEPTURL/faculty/amba">Amba Kulkarni</a></span></p>
</td>
<td>
<p> <span class="cons1"><a href="SCLURL/contributors.html">Contributors</a></span></p>
</td>
</tr>
</table>
</center>
</div>
</div><!--container-div ends here -->
<div id="outout"> </div>
<div>
<div id="counter">
<!-- Start of StatCounter Code for Default Guide -->
<script type="text/javascript" src="SCLURL/statcounter.js">
</script>
<noscript><div class="statcounter"><a title="web analytics" href="http://statcounter.com/" target="_blank"><img class="statcounter" src="https://c.statcounter.com/8421849/0/34917efe/0/" alt="web analytics"/></a></div></noscript>
<!-- End of StatCounter Code for Default Guide -->
</div>
</body>
</html>
};

 
print $head;

while($in = <STDIN>){
 while($in =~ /<form wx=/) {
   if($in =~ /<form wx="([^"]+)"/) { print $1," "};
   $in =~ s/<form wx="[^"]+"//;
 }
}
print "<\/font>\n";

print $tail;
