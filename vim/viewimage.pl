#!/usr/bin/perl

use Getopt::Std;
use Tk;
use Tk::JPEG;
require Tk::FileSelect;

$g_win       = undef;
$g_canvas    = undef;
$g_image_tag = undef;

sub load_file
{
   my $file = $_[0];

   $img = $g_win->Photo(-file => "$file",
                        -width => 200, -height => 200);
   $img2 = $img->copy($img, -shrink => 'yes');

   $g_label->configure(-image => $img2);

   #if ($g_image_tag != undef)
   #{
      #$g_canvas->delete($g_image_tag);
   #}
   #$g_image_tag = $g_canvas->createImage(50, 50, -image => $file);
}

# ============================================================================
sub accept_file
{
   printf "foo";
   exit
}

# ============================================================================
sub file_chosen
{
   return (0);
}

# ============================================================================
sub select_file
{
   #$FSref = $g_win->FileSelect(-directory => ".");
         #-accept => [\&file_chosen]);
         #-verify => ['-d']);
         #-filelabel => "$g_file_prefix$file_num\.$g_file_ext",
   #$file = $FSref->Show();
   $file = $g_win->getOpenFile;
   printf "selected $file\n";
   load_file ($file);
}

# ============================================================================
# build the main GUI window.
sub build_main
{
   # The main window.
   $g_win = MainWindow->new;
   $g_win->title("Select Image");

   # the Rotate left and right buttons on the left and right side of the canvas
   #$g_canvas = $g_win->Canvas(-height => 100, -width => 100)->
      #pack(-side => 'top');
   $g_label = $g_win->Label();
   $g_label->pack(-side => 'top');


   # Create a bottom frame for the overall quit and quit-no-save buttons.
   $but_bar2 = $g_win->Frame()->pack(-side => 'bottom');
   $but_bar2->Button(-text => "Accept",
      -command => [\&accept_file])->pack(-side => 'left');
   $but_bar2->Button(-text => "Choose...",
      -command => [\&select_file])->pack(-side => 'left');
   $but_bar2->Button(-text => "Quit", -command => sub {exit})
      ->pack(-side => 'left');

}

# ====================================================================================
# main code here.
if ( !(getopts ('h')) )
{
	usageAndExit;
}

if (defined $opt_h)
{
	usageAndExit;
}

if ($ARGV[0] == undef)
{
   usageAndExit;
}

# must build main before loading image.  (it builds the picture canvas)
build_main();

MainLoop;

