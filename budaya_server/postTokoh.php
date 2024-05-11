<?php

header("Access-Control-Allow-Origin: *");

include 'koneksi.php';

$response = array('isSuccess' => false, 'message' => 'Unknown error occurred');

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    if (isset($_POST['id']) && isset($_POST['nama']) && isset($_POST['tgl_lahir']) && isset($_POST['asal']) && isset($_POST['jenis_kelamin']) && isset($_POST['deskripsi'])) {
        $id = $_POST['id'];
        $nama = $_POST['nama'];
        $tgl_lahir = $_POST['tgl_lahir'];
        $asal = $_POST['asal'];
        $jenis_kelamin = $_POST['jenis_kelamin'];
        $deskripsi = $_POST['deskripsi'];
        $fotoPath = isset($_FILES['foto']['name']) ? $_FILES['foto']['name'] : '';

        // Handle file upload
        if (!empty($fotoPath)) {
            $targetDir = "tokoh/";
            $targetFilePath = $targetDir . basename($_FILES["foto"]["name"]);
            $fileType = strtolower(pathinfo($targetFilePath,PATHINFO_EXTENSION));
            // Allow certain file formats
            $allowTypes = array('jpg','png','jpeg');
            if(in_array($fileType, $allowTypes)){
                // Upload file to server
                if(move_uploaded_file($_FILES["foto"]["tmp_name"], $targetFilePath)){
                    $foto = $targetFilePath; // Update foto path to use in SQL
                } else {
                    $response['message'] = "Sorry, there was an error uploading your file.";
                    echo json_encode($response);
                    exit;
                }
            } else {
                $response['message'] = "Sorry, only JPG, JPEG, & PNG files are allowed.";
                echo json_encode($response);
                exit;
            }
        } else {
            // Use existing foto path if new foto is not uploaded
            $sql = "SELECT foto FROM sejarawan WHERE id = '$id'";
            $result = $koneksi->query($sql);
            if($result->num_rows > 0){
                $row = $result->fetch_assoc();
                $foto = $row['foto'];
            } else {
                $response['message'] = "No record found to update.";
                echo json_encode($response);
                exit;
            }
        }

        $sql = "UPDATE sejarawan SET nama='$nama', foto='$foto', tgl_lahir='$tgl_lahir', asal='$asal', jenis_kelamin='$jenis_kelamin', deskripsi='$deskripsi' WHERE id='$id'";
        if ($koneksi->query($sql) === TRUE) {
            $response['isSuccess'] = true;
            $response['message'] = "Berhasil mengedit data sejarawan";
        } else {
            $response['isSuccess'] = false;
            $response['message'] = "Gagal mengedit data sejarawan: " . $koneksi->error;
        }
    } else {
        $response['isSuccess'] = false;
        $response['message'] = "Parameter tidak lengkap";
    }
} else {
    $response['isSuccess'] = false;
    $response['message'] = "Metode yang diperbolehkan hanya POST";
}

echo json_encode($response);
?>