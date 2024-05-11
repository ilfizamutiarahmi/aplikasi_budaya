<?php

header("Access-Control-Allow-Origin: header");
header("Access-Control-Allow-Origin: *");

include 'koneksi.php';

$id = $_POST['id'];
$name = $_POST['name'];
$phone = $_POST['phone'];

$sql = "UPDATE user SET name = '$name', phone = '$phone' WHERE id=$id";
$isSuccess = $koneksi->query($sql);

$res = [];
if ($isSuccess) {

    $cek = "SELECT * FROM user WHERE id = $id";
    $result = mysqli_fetch_assoc(mysqli_query($koneksi, $cek));

    $res['is_success'] = true;
    $res['value'] = 1;
    $res['message'] = "Berhasil edit data user";
    $res['name'] = $result['name'];
    $res['phone'] = $result['phone'];
    $res['id'] = $result['id'];
} else {
    $res['is_success'] = false;
    $res['value'] = 0;
    $res['message'] = "Gagal edit data user";
}

// Mengirim respon dalam format JSON
echo json_encode($res);

?>
