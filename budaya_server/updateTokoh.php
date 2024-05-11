<?php

header("Access-Control-Allow-Origin: header");
header("Access-Control-Allow-Origin: *");

include 'koneksi.php';

$id = $_POST['id'];
$nama = $_POST['nama'];
$tgl_lahir = $_POST['tgl_lahir'];
$asal = $_POST['asal'];
$jenis_kelamin = $_POST['jenis_kelamin'];
$deskripsi = $_POST['deskripsi'];
$foto = $_POST['foto'];


$sql = "UPDATE tokoh SET nama = '$nama', tgl_lahir = '$tgl_lahir', asal = '$asal', jenis_kelamin = '$jenis_kelamin', deskripsi = '$deskripsi', foto = '$foto' WHERE id=$id";
$isSuccess = $koneksi->query($sql);


$res = [];
if ($isSuccess) {
    $cek = "SELECT * FROM tokoh WHERE id = $id";
    $result = mysqli_fetch_assoc(mysqli_query($koneksi, $cek));

    $res['is_success'] = true;
    $res['value'] = 1;
    $res['message'] = "Berhasil edit data tokoh adat";
    $res['nama'] = $result['nama'];
    $res['tgl_lahir'] = $result['tgl_lahir'];
    $res['asal'] = $result['asal'];
    $res['jenis_kelamin'] = $result['jenis_kelamin'];
    $res['deskripsi'] = $result['deskripsi'];
    $res['foto'] = $result['foto'];
    $res['id'] = $result['id'];
} else {
    $res['is_success'] = false;
    $res['value'] = 0;
    $res['message'] = "Gagal edit data tokoh Adat";
}


echo json_encode($res);

?>
