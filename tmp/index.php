<?php

// script utilisé pour afficher
// tous les headers
// de la requête HTTP

header('Content-Type: application/json');
echo json_encode(getallheaders(), JSON_PRETTY_PRINT);