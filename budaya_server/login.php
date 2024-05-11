<?php

header("Access-Control-Allow-Origin: *");

include 'koneksi.php';

if($_SERVER['REQUEST_METHOD'] == "POST") {
    $response = array();
    $email = $_POST['email'];
    $password = md5($_POST['password']);

    $cek = "SELECT * FROM user WHERE email = '$email' AND password = '$password'";
    $result = mysqli_query($koneksi, $cek);

    if(mysqli_num_rows($result) > 0) {
        $row = mysqli_fetch_assoc($result);
        $response['value'] = 1;
        $response['message'] = "berhasil login";
        $response['name'] = $row['name'];
        $response['phone'] = $row['phone'];
        $response['email'] = $row['email'];
        $response['id'] = $row['id'];
        echo json_encode($response);
    } else {
        $response['value'] = 0;
        $response['message'] = "Gagal login";
        echo json_encode($response);
    }
}

?>
