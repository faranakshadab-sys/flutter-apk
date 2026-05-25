package com.didbanarad.parkingandroid;

import android.os.Build;

import androidx.annotation.RequiresApi;

import java.util.Base64;

public class ImageUtility {

    @RequiresApi(api = Build.VERSION_CODES.O)
    public static byte[] decodeBase64(String base64String) {
        byte[] decodedBytes = Base64.getDecoder().decode(base64String);
        System.out.println(decodedBytes);
            return  decodedBytes;
    }






}
