<?php
header("Content-Type: application/json");
include 'db.php';

$method = $_SERVER['REQUEST_METHOD'];
$id = isset($_GET['id']) ? intval($_GET['id']) : null;

switch ($method) {
    case 'GET':
        if ($id) {
            $sql = "SELECT * FROM items WHERE id = $id";
            $result = $conn->query($sql);
            if ($result->num_rows > 0) {
                $data = $result->fetch_assoc();
                http_response_code(200);
            } else {
                $data = ['error' => 'Record not found'];
                http_response_code(404);
            }
        } else {
            $sql = "SELECT * FROM items";
            $result = $conn->query($sql);
            $data = [];
            while ($row = $result->fetch_assoc()) {
                $data[] = $row;
            }
            http_response_code(200);
        }
        echo json_encode($data);
        break;

    case 'POST':
        $input = json_decode(file_get_contents('php://input'), true);
        if (isset($input['kode'], $input['nama'], $input['qty'])) {
            $kode = $conn->real_escape_string($input['kode']);
            $nama = $conn->real_escape_string($input['nama']);
            $qty = intval($input['qty']);
            $sql = "INSERT INTO items (kode, nama, qty) VALUES ('$kode', '$nama', $qty)";
            if ($conn->query($sql) === TRUE) {
                echo json_encode(['id' => $conn->insert_id]);
                http_response_code(201);
            } else {
                echo json_encode(['error' => $conn->error]);
                http_response_code(500);
            }
        } else {
            echo json_encode(['error' => 'Input tidak valid']);
            http_response_code(400);
        }
        break;

    case 'PUT':
        if ($id) {
            $input = json_decode(file_get_contents('php://input'), true);
            if (isset($input['kode'], $input['nama'], $input['qty'])) {
                $kode = $conn->real_escape_string($input['kode']);
                $nama = $conn->real_escape_string($input['nama']);
                $qty = intval($input['qty']);
                $sql = "UPDATE items SET kode='$kode', nama='$nama', qty=$qty WHERE id=$id";
                if ($conn->query($sql) === TRUE) {
                    echo json_encode(['message' => 'Record updated successfully']);
                    http_response_code(200);
                } else {
                    echo json_encode(['error' => $conn->error]);
                    http_response_code(500);
                }
            } else {
                echo json_encode(['error' => 'Input tidak valid']);
                http_response_code(400);
            }
        } else {
            echo json_encode(['error' => 'ID tidak ditemukan']);
            http_response_code(404);
        }
        break;

    case 'DELETE':
        if ($id) {
            $sql = "DELETE FROM items WHERE id = $id";
            if ($conn->query($sql) === TRUE) {
                echo json_encode(['message' => 'Record deleted successfully']);
                http_response_code(200);
            } else {
                echo json_encode(['error' => $conn->error]);
                http_response_code(500);
            }
        } else {
            echo json_encode(['error' => 'ID tidak ditemukan']);
            http_response_code(404);
        }
        break;

    default:
        echo json_encode(['message' => 'Metode tidak didukung']);
        http_response_code(405);
        break;
}

$conn->close();
?>
