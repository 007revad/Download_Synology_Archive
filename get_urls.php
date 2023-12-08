<?php
//--------------------------------------------------------------------
// Forked from https://github.com/stopforumspam/download-synology-dsm
//--------------------------------------------------------------------
// https://github.com/007revad/Download_Synology_Archive
//
// Required script for syno_archive_clone.sh
//--------------------------------------------------------------------

if (isset($argv[1])) {
    //echo "$argv[1]" . "\n";  // debug
    $srcdir = "$argv[1]";
}

function getDirs($url, $srcdir, $type) {
    $html = file_get_contents($url);
    $dom = new DOMDocument;
    @$dom->loadHTML($html);
    foreach ($dom->getElementsByTagName('a') as $node) {

        $remote = parse_url($node->getAttribute("href"));
        $fullpath = explode("/", $remote["path"]);
        $type = urldecode(array_pop($fullpath));

        if ($type != "download") {
            echo "\"" . $type . "\" ";  // output to bash script
            $path = "download/$srcdir/$type/";
        }
    }
}

if ( (isset($srcdir)) && (!empty($srcdir)) ) {
    getDirs("https://archive.synology.com/download/$srcdir", "$srcdir", "");
} else {
    getDirs("https://archive.synology.com/download", "", "");
}
echo "\n";

exit();

