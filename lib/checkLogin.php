<?php
$json = file_get_contents('php://input') ;
$obj = json_decode($json,true) ;
$email = $obj['email'] ;
$password = $obj['password'] ;
$host_user = 'user@msu.ac.th' ;
$host_password = 'abc123' ;
$result = array() ;
if($email == $host_user && $password ==$host_password )
{
  $result['status'] = 'login' ;
  $result['message'] = 'Login Completed' ;
}
else {
  $result['status'] = '' ;
  $result['message'] = 'Invalid Username or Password' ;
}
echo json_encode($result) ;
?>