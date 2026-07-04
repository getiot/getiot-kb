<?php

$path = $_SERVER['PHP_SELF'];
echo basename($path)."\n";
echo getcwd()."\n";
mkdir("test");
