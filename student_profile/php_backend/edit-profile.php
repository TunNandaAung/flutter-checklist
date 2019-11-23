<?php
header('Content-Type: application/json; charset=UTF-8');

$response = array();
$server_url = 'http://127.0.0.1:8000';
$post = (array)json_decode(file_get_contents("php://input"));

if (isset($post["id"])) {

    $id = $post["id"];
    $uno = $post['uno'];
    $startingyear = $post['startingyear'];
    $mmSName = $post['mmSName'];
    $enSName  = $post['enSName'];
    $nrc = $post['nrc'];
    $nationaity = $post['nationality'];
    $religion = $post['religion'];
    $hometown = $post['hometown'];
    $township = $post['township'];
//    //$division = $post['division'];
    //$citizenship = $post['citizenship'];
    $dateOfBirth =  $post['dateOfBirth'];
    $bloodtype = $post['bloodtype'];
    $phoneNo = $post['phoneNo'];
    $lastRollNo = $post['lastRollNo'];
    $matriRollNo = $post['matriRollNo'];
    $matriYear = $post['matriYear'];
    $matriexamdept = $post['matriexamdept'];
//    //$address = $post['address'];

    $f_mmFName = $post['mmFName'];
    $f_enFName  = $post['enFName'];
    $f_nationaity = $post['f_nationality'];
    $f_religion = $post['f_religion'];
    $f_hometown = $post['f_hometown'];
    $f_township = $post['f_township'];
    $f_phoneNo = $post['f_phoneNo'];
    $f_nrc = $post['f_nrc'];
    $f_job = $post['f_job'];
    $f_position = $post['f_position'];
    $f_department= $post['f_department'];
    $f_address= $post['f_address'];

    $m_mmMName = $post['mmMName'];
    $m_enMName  = $post['enMName'];
    $m_nationality = $post['m_nationality'];
    $m_religion = $post['m_religion'];
    $m_hometown = $post['m_hometown'];
    $m_township = $post['m_township'];
    $m_phoneNo = $post['m_phoneNo'];
    $m_nrc = $post['m_nrc'];
    $m_job = $post['m_job'];
    $m_position = $post['m_position'];
    $m_department= $post['m_department'];
    $m_address= $post['m_address'];

    $m_id = $post['m_id'];
    $f_id= $post['f_id'];

    //$address = $post['address'];


    $mysqli = mysqli_connect('127.0.0.1:3306','root','','student_profile');
    mysqli_set_charset($mysqli,'utf8mb4');

    $query = "  Update student_info
                SET student_info.enSName = '$enSName',
                    student_info.mmSName = '$mmSName',
                    student_info.enSName = '$enSName',
                    student_info.nationality = '$nationaity',
                    student_info.religion = '$religion',
                    student_info.hometown = '$hometown',
                    student_info.township = '$township', 
                    student_info.nrc = '$nrc',
                    student_info.dateOfBirth = '$dateOfBirth',
                    student_info.bloodtype = '$bloodtype',
                    student_info.lastRollNo = '$lastRollNo',
                    student_info.matriRollNo = '$matriRollNo',
                    student_info.matriYear = '$matriYear',
                    student_info.matriexamdept = '$matriexamdept'
                where student_info.s_id='$id';";

    $query.= " Update student_father 
                SET student_father.enFName = '$f_enFName',
                    student_father.mmFName = '$f_mmFName',
                    student_father.nationality= '$f_nationaity',
                    student_father.religion = '$f_religion',
                    student_father.hometown ='$f_hometown',
                    student_father.township = '$f_township',
                    student_father.nrc = '$f_nrc',
                    student_father.job = '$f_job',
                    student_father.position = '$f_position',
                    student_father.department= '$f_department',
                    student_father.f_address= '$f_address'
                where student_father.s_f_id='$f_id';
                ";

   $query.= "  Update student_mother 
                SET  student_mother.enMName = '$m_enMName',
                     student_mother.mmMName = '$m_mmMName',
                     student_mother.nationality= '$m_nationality',
                     student_mother.religion = '$m_religion',
                     student_mother.hometown ='$m_hometown',
                     student_mother.township = '$m_township',
                     student_mother.nrc = '$m_nrc',
                     student_mother.job = '$m_job',
                     student_mother.position = '$m_position',
                     student_mother.department= '$m_department',
                     student_mother.m_address= '$m_address'
                where student_mother.s_m_id='$m_id';
                ";
    if( mysqli_multi_query($mysqli,$query)){
        $response = array(
            "status" => "success",
            "error" => false,
            "message" => "Info Updated successfully",
        );
    }
    else{
        http_response_code(404);
        $response = array(
            "status" => "error",
            "error" => true,
            "message" => "Error Updating info!"
        );
    }
}else {
    http_response_code(404);
    $response = array(
        "status" => "error",
        "error" => true,
        "message" => "Error updating info! No ID Specified",
    );

}
echo json_encode($response);
?><?php
