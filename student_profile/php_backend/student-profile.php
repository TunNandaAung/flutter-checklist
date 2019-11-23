<?php
header('Content-Type: application/json; charset=UTF-8');
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET");

$response = array();
$server_url = 'http://127.0.0.1:8000';

    if (isset($_GET['id'])) {

        $id = $_GET['id'];
        $mysqli = new mysqli('127.0.0.1:3306','root','','student_profile');

        mysqli_set_charset($mysqli,'utf8mb4');

        $query = "Select student_info.*,student_father.*,student_mother.* from student_info left join student_father on 
                   student_info.s_f_id = student_father.s_f_id left join  student_mother on 
                   student_info.s_m_id = student_mother.s_m_id where student_info.s_id=$id";

        try{
            $data = $mysqli->query($query);
        }catch (mysqli_sql_exception $e){
            $response = array(
                "status" => "error",
                "error" => true,
                "message" => "Error fetching info!"
            );
            echo json_encode($response);
            exit();
        }
        if( $data->fetch_array() != null){
            $response = array(
                "status" => "success",
                "error" => false,
                "message" => "Fetched info successfully",
                "data" => $data->fetch_array()
            );
        }
        else{
            $response = array(
                "status" => "error",
                "error" => true,
                "message" => "Error fetching info!"
            );
        }
    }else {
    $response = array(
        "status" => "error",
        "error" => true,
        "message" => "Error fetching info!"
    );

}
echo json_encode($response);
?>