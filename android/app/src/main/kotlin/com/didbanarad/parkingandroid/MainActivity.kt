package com.didbanarad.parkingandroid

import android.content.Intent
import android.os.Build
import android.util.Base64.DEFAULT
import android.util.Base64.decode
import androidx.annotation.NonNull
import androidx.annotation.RequiresApi
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.EventChannel.EventSink
import io.flutter.plugin.common.MethodChannel
import org.json.JSONObject
import java.awt.*
import java.util.*


class MainActivity : FlutterActivity() {
    val PLATFORMCHANNEL =  "parking/receipt-platform-channel"
    val EVENTCHANNEL="parking/receipt-event-channel"
    var eventSink:EventSink?=null ;
    var entryDate:String?=null;
    var exitDate:String?=null;
    var entryHour:String?=null;
    var exitHour:String?=null;
    var plateBytes:ByteArray?=null;
    var totalAmount:String? =null;
    var totalParkTime:String?=null;
    var parkingName:String? = null;
    var  parkingAddress:String?=null;
    var  parkingPhone:String? =null;



    @RequiresApi(Build.VERSION_CODES.O)
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            PLATFORMCHANNEL
        ).setMethodCallHandler { call, result ->
            if (call.method == "sendTransaction") {
                var arguments=call.arguments.toString();
                var jsonRepresentationOfPaymentDataObject =
                    """{"applicationId":10064,"printPaymentDetails":false,"saveDetail":false,"sessionId":"sessionId1515774896730781896","totalAmount":${arguments},"transactionType":"PURCHASE","versionName":"1.0.0"}"""
                val intent = Intent("com.bpmellat.merchant")
                intent.putExtra("PaymentData", jsonRepresentationOfPaymentDataObject);
                startActivityForResult(intent, 1000);
                result.success("This is From Navtive Side sendTransaction")
            } else if(call.method == "printMarginalParkPaymentReceipt") {
                var arguments=call.arguments.toString();
                var jsonArguments=JSONObject(arguments.substring(arguments.indexOf("{"), arguments.lastIndexOf("}") + 1));
                
                // extract data from json
                var totalAmount = jsonArguments.getString("totalAmount");
                var totalParkTime = jsonArguments.getString("totalParkTime");
                var paymentStatus = jsonArguments.getString("paymentStatus");
                var submitDateTime = jsonArguments.getString("submitDateTime");
                var plateImageBytes = ImageUtility.decodeBase64(jsonArguments.getString("plateImageBytes"));
                
                // print
                PrinterUtility(context)
                    .printTheMarginalParkPaymentReceipt(
                        totalAmount,
                        totalParkTime,
                        paymentStatus,
                        submitDateTime,
                        plateImageBytes);

                result.success("This is from navtive side printMarginalParkPaymentReceipt")
            }       
            else if(call.method == "printArrivalReceipt") {
                var arguments=call.arguments.toString();
                var jsonArguments=JSONObject(arguments.substring(arguments.indexOf("{"), arguments.lastIndexOf("}") + 1));
                var entryDate:String = jsonArguments.getString("entryDate");
                var entryHour:String = jsonArguments.getString("entryHour");
                var qrImageBytes=  ImageUtility.decodeBase64(jsonArguments.getString("qrBytes"));
                var plateImageBytes=  ImageUtility.decodeBase64(jsonArguments.getString("plateBytes"));
                var parkingAddress:String = jsonArguments.getString("parkingAddress");
                var parkingName:String = jsonArguments.getString("parkingName");
                var parkingPhone:String = jsonArguments.getString("parkingPhone");
                PrinterUtility(context).printTheArrivalReceipt(entryDate,entryHour,qrImageBytes,plateImageBytes,parkingPhone,parkingName,parkingAddress);
                result.success("This is From Navtive Side printArrivalReceipt")
            }else if(call.method == "printExitReceipt"){
                var arguments=call.arguments.toString();
                var jsonArguments=JSONObject(arguments.substring(arguments.indexOf("{"), arguments.lastIndexOf("}") + 1));
                var exitDateValue:String = jsonArguments.getString("exitDate");
                var entryDateValue:String = jsonArguments.getString("entryDate");
                var entryHourValue:String = jsonArguments.getString("entryHour");
                var exitHourValue:String = jsonArguments.getString("exitHour");
                var plateValue:ByteArray = ImageUtility.decodeBase64(jsonArguments.getString("plateBytes"));
                var parkingAddressValue:String = jsonArguments.getString("parkingAddress");
                var parkingNameValue:String = jsonArguments.getString("parkingName");
                var parkingPhoneValue:String = jsonArguments.getString("parkingPhone");
                var totalAmountValue:String = jsonArguments.getString("totalAmount");
                var totalParkTimeValue:String = jsonArguments.getString("totalParkTime");
                var paymentStatusText:String=jsonArguments.getString("paymentStatusText");




                PrinterUtility(context).printTheExitReceipt(
                   entryDateValue,
                    entryHourValue,
                    exitDateValue,
                    exitHourValue,
                    plateValue,
                    totalAmountValue,
                    paymentStatusText,
                    parkingPhoneValue,
                    parkingNameValue,
                    parkingAddressValue,
                    totalParkTimeValue
                    );
            }else {
                result.notImplemented()
            }
        }


        EventChannel(flutterEngine.dartExecutor.binaryMessenger, EVENTCHANNEL).setStreamHandler(
            object : EventChannel.StreamHandler {
                override fun onListen(args: Any?, events: EventSink?) {
                    println("adding listener")
                    eventSink = events
                    events?.success(true)
                }

                override fun onCancel(args: Any?) {
                    println("cancelling listener")
                }
            })
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (requestCode == 1000) {
            println(resultCode)
            if (resultCode == RESULT_OK) {
                val result: String? = data?.getStringExtra("PaymentResult")

                eventSink?.success(result)
            }

            if (resultCode == RESULT_CANCELED) {
                eventSink?.success("FAIL")
                println("FAIL")
            }
        }
    }


}
