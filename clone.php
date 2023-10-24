<?php
function getLinks($url, $dir) {

    $html = file_get_contents($url);
    $dom = new DOMDocument;
    @$dom->loadHTML($html);
    foreach ($dom->getElementsByTagName('a') as $node) {
        if (strpos($node->getAttribute("href"), ".pat") !== false || strpos($node->getAttribute("href"), ".zip") !== false) {

            //echo "FILE: " . $node->getAttribute("href")."\n" ; 

            $remote = parse_url($node->getAttribute("href"));
            $fullpath = explode("/", $remote["path"]);
            $filename = urldecode(array_pop($fullpath));
            $path = "download/Os/DSM/$dir/";

            //echo "mkdir: " . "$path \n";

            @mkdir($path, 0777, true);
            $dest = "$path$filename";

	        // getting remote file size
            $ch = curl_init($node->getAttribute("href"));
            curl_setopt($ch, CURLOPT_NOBODY, true);
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
            curl_setopt($ch, CURLOPT_HEADER, true);
            curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
            $data = curl_exec($ch);
            curl_close($ch);

            $contentLength = 'unknown';
            $status = 'unknown';
            if (preg_match('/^HTTP\/(1\.[01]|2) (\d\d\d)/', $data, $matches)) {
                 $status = (int)$matches[2];
            }
            if (preg_match('/Content-Length: (\d+)/i', $data, $matches)) {
                 $contentLength = (int)$matches[1];
            }

            if ($status == 200 && $contentLength <> "unknown" && file_exists($dest) && (filesize($dest) != $contentLength)) {
                echo "Remote file is $contentLength however local file is " . filesize($dest) . ", Redownloading\n";
                @unlink($dest);
            }

            if (!file_exists($dest)) {
                //echo "downloading " . $node->getAttribute("href") . " to $dest \n";
                echo "Downloading: " . "$dest \n";
                // echo "From: " . $node->getAttribute("href") . "\n\n";

                $fh = fopen($dest, "w");
                $ch = curl_init();
                curl_setopt($ch, CURLOPT_USERAGENT,"Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:109.0) Gecko/20100101 Firefox/113.0 ");             
                curl_setopt($ch, CURLOPT_URL, $node->getAttribute("href"));
                curl_setopt($ch, CURLOPT_FILE, $fh);
                curl_exec($ch);
                curl_close($ch); 
//            } else {
//                // echo "Skipping download\n";
//                echo "Skipping: " . "$dest \n";
            }
        } else
        if (strpos($node->getAttribute("href"), "/download/Os/DSM/") !== false) {
            echo "DIR: " . $node->getAttribute("href")."\n";
            $url = "https://archive.synology.com" .$node->getAttribute("href");
            getLinks($url,  $node->nodeValue);
        }
    }
}
getLinks("https://archive.synology.com/download/Os/DSM" , "");
