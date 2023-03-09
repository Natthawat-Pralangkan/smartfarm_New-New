<?php
include 'conn.php';
header("Access-Control-Allow-Origin: *");
if (isset($_GET)) {
    if ($_GET['isAdd'] == 'true') {
        $result = mysqli_query($conn, "SELECT * FROM tb_environment   WHERE farm_id = '".$_GET['farm_id']."' LIMIT 20 ");
        if ($result) {
            while($row=mysqli_fetch_assoc($result)){
                $output[]= array(
                    "farm_id"=>$row['farm_id'],
                    "docno"=>$row['docno'],
                    "device_id"=>$row['device_id'],
                    "datekey"=>$row['datekey'],
                    "timekey"=>$row['timekey'],
                    "temp"=>$row['temp'],
                    "humid"=>$row['humid'],
                    "light"=>$row['light'],
                    "soild_1"=>$row['soild_1'],
                    "soild_2"=>$row['soild_2'],
                    "fer_n"=>$row['fer_n'],
                    "fer_p"=>$row['fer_p'],
                    "fer_k"=>$row['fer_k'],
                    "water_temp"=>$row['water_temp'],
                    // "soild_moisture"=>$row['soild_moisture'],
                );
            }   // while
            echo json_encode($output);
        } //if
    } else if ($_GET['isAdd'] == 'item') {
        $result = mysqli_query($conn, "SELECT * FROM tb_environment WHERE farm_id = '".$_GET['farm_id']."'");
        if ($result) {
            $res = mysqli_fetch_assoc($result);
            echo json_encode($res);
        } 
    }else echo "Welcome Master UNG";
}   // if1
mysqli_close($conn);
?>