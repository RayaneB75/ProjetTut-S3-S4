<?php
/*
**  Plugin Name:  WordPress Permissions Fixer
**  Plugin URI:   https://endurtech.com/wordpress-permissions-fixer-script/
**  Description:  Simple php script sets correct directory and file permissions on WordPress and others. Directories are 755, files are 644, wp-config.php is 444.
**  Author:       Manuel Rodrigues
**  Author URI:   https://endurtech.com
**  Version:      1.1
**  Tags:         wordpress, php, script, directory, directories, file, files, wp-config.php, chmod, fix
**  License:      GPL-2.0+
*/

file_fix_directory( dirname(__FILE__) );

function file_fix_directory( $dir, $nomask = array( '.', '..' ) )
{
  if ( is_dir( $dir ) )
  {
    // Reset directories
    if ( @chmod( $dir, 0755 ) )
    {
      echo "<p>Fixed: " . $dir . "</p>";
    }
  }
  if ( is_dir( $dir ) && $handle = opendir( $dir ) )
  {
    while ( false !== ( $file = readdir ( $handle ) ) )
    {
      if ( !in_array( $file, $nomask ) && $file[0] != '.' )
      {
        if ( is_dir( "$dir/$file" ) )
        {
          // Recurse into subdirectories
          file_fix_directory( "$dir/$file", $nomask );
        }
        else
        {
          $filename = "$dir/$file";
          // Reset files
          if ( @chmod( $filename, 0644 ) )
          {
            echo "<p>Fixed: " . $filename . "</p>";
          }
        }
      }
    }
    closedir( $handle );
  }
}

unlink(__FILE__);

echo "<p>&nbsp;</p>
<p>Your Directory and File Permissions have been Reset.<br />Please close this window and remove the <span style=\"background-color:#cccccc;\">permissions-fix.php</span> file from your webserver.</p>";

?>