package com.didbanarad.parkingandroid;

import android.content.Context;
import android.content.res.AssetManager;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Typeface;
import android.os.AsyncTask;
import com.pax.gl.page.IPage;
import com.pax.gl.page.PaxGLPage;
import java.io.IOException;
import java.io.InputStream;

public class PrinterUtility {

  private static Device device;
  private static Context appContext;
  private static final int FONT_SMALL = 20;
  private static final int FONT_NORMAL = 24;
  Typeface persianFont;

  public PrinterUtility(Context context) {
    appContext = context;
    device = Device.getInstance(context);
    persianFont =
      Typeface.createFromAsset(appContext.getAssets(), "fonts/IranSans.ttf");
  }

  public void printTheExitReceipt(
    String entryDate,
    String entryHour,
    String exitDate,
    String exitHour,
    byte[] plate,
    String totalAmount,
    String paymentStatus,
    String parkingPhone,
    String parkingName,
    String parkingAddress,
    String totalParkTime
  ) {
    new ExitPrinter(
      exitDate,
      entryDate,
      entryHour,
      exitHour,
      plate,
      totalAmount,
      paymentStatus,
      parkingPhone,
      parkingName,
      parkingAddress,
      totalParkTime
    )
      .executeOnExecutor(AsyncTask.THREAD_POOL_EXECUTOR);
  }

  public void printTheArrivalReceipt(
    String entryDate,
    String entryHour,
    byte[] qrBytes,
    byte[] plateBytes,
    String parkingPhone,
    String parkingName,
    String parkingAddress
  ) {
    new ArrivalPrinter(
      entryDate,
      entryHour,
      qrBytes,
      plateBytes,
      parkingPhone,
      parkingName,
      parkingAddress
    )
      .executeOnExecutor(AsyncTask.THREAD_POOL_EXECUTOR);
  }

  public void printTheMarginalParkPaymentReceipt(
    String totalAmount,
    String totalParkTime,
    String paymentStatus,
    String submitDateTime,
    byte[] plateImageBytes
  ) {
    new MarginalParkPaymentPrinter(
      totalAmount,
      totalParkTime,
      paymentStatus,
      submitDateTime,
      plateImageBytes
    )
      .executeOnExecutor(AsyncTask.THREAD_POOL_EXECUTOR);
  }

  public class ExitPrinter extends AsyncTask {

    String entryDate;
    String entryHour;
    String exitDate;
    String exitHour;
    Bitmap plate;
    String totalAmount;
    String paymentStatus;
    String parkingPhone;
    String parkingName;
    String parkingAddress;
    String totalParkTime;

    public ExitPrinter(
      String exitDateValue,
      String entryDateValue,
      String entryHourValue,
      String exitHourValue,
      byte[] plateValue,
      String totalAmountValue,
      String paymentStatusValue,
      String parkingPhoneValue,
      String parkingNameValue,
      String parkingAddressValue,
      String totalParkTimeValue
    ) {
      entryDate = entryDateValue;
      entryHour = entryHourValue;
      exitHour = exitHourValue;
      plate = BitmapFactory.decodeByteArray(plateValue, 0, plateValue.length);
      totalAmount = totalAmountValue;
      paymentStatus = paymentStatusValue;
      exitDate = exitDateValue;
      parkingAddress = parkingAddressValue;
      parkingName = parkingNameValue;
      parkingPhone = parkingPhoneValue;
      totalParkTime = totalParkTimeValue;
    }

    @Override
    protected Object doInBackground(Object[] objects) {
      try {
        device.print(
          generateExitBitmap(
            exitDate,
            entryDate,
            entryHour,
            exitHour,
            plate,
            totalAmount,
            paymentStatus,
            parkingPhone,
            parkingName,
            parkingAddress,
            totalParkTime
          ),
          new IPosPrinterEvent() {
            @Override
            public void onPrintStarted() {}

            @Override
            public void onPrinterError(String error, boolean isPaperError) {}

            @Override
            public void onPrintEnd() {}
          }
        );
      } catch (Exception e) {
        e.printStackTrace();
      }
      return null;
    }
  }

  public class ArrivalPrinter extends AsyncTask {

    String entryDate;
    String entryHour;
    byte[] qrCodeBytes;
    Bitmap qrBitmap = null;
    byte[] plateImageByte;
    Bitmap plateBitmap;
    String parkingPhone;
    String parkingName;
    String parkingAddress;

    public ArrivalPrinter(
      String entryDateValue,
      String entryHourValue,
      byte[] qrCodeBytesValue,
      byte[] plateImageBytesValue,
      String parkingPhoneValue,
      String parkingNameValue,
      String parkingAddressValue
    ) {
      entryDate = entryDateValue;
      entryHour = entryHourValue;
      qrCodeBytes = qrCodeBytesValue;
      qrBitmap =
        BitmapFactory.decodeByteArray(
          qrCodeBytesValue,
          0,
          qrCodeBytesValue.length
        );
      plateImageByte = plateImageBytesValue;
      plateBitmap =
        BitmapFactory.decodeByteArray(
          plateImageBytesValue,
          0,
          plateImageBytesValue.length
        );
      parkingAddress = parkingAddressValue;
      parkingName = parkingNameValue;
      parkingPhone = parkingPhoneValue;
    }

    @Override
    protected Object doInBackground(Object[] objects) {
      try {
        device.print(
          generateArrivalBitmap(
            entryDate,
            entryHour,
            qrBitmap,
            plateBitmap,
            parkingPhone,
            parkingName,
            parkingAddress
          ),
          new IPosPrinterEvent() {
            @Override
            public void onPrintStarted() {}

            @Override
            public void onPrinterError(String error, boolean isPaperError) {}

            @Override
            public void onPrintEnd() {}
          }
        );
      } catch (Exception e) {
        e.printStackTrace();
      }
      return null;
    }
  }

  public class MarginalParkPaymentPrinter extends AsyncTask {

    Bitmap plate;
    String totalAmount;
    String totalParkTime;
    String paymentStatus;
    String submitDateTime;

    public MarginalParkPaymentPrinter(
      String totalAmount,
      String totalParkTime,
      String paymentStatus,
      String submitDateTime,
      byte[] plateImageBytes
    ) {
      this.totalAmount = totalAmount;
      this.totalParkTime = totalParkTime;
      this.paymentStatus = paymentStatus;
      this.submitDateTime = submitDateTime;
      this.plate =
        BitmapFactory.decodeByteArray(
          plateImageBytes,
          0,
          plateImageBytes.length
        );
    }

    @Override
    protected Object doInBackground(Object[] objects) {
      try {
        Bitmap bitmap = generateMarginalParkPaymentBitmap(
          this.plate,
          this.totalAmount,
          this.totalParkTime,
          this.paymentStatus,
          this.submitDateTime
        );

        device.print(
          bitmap,
          new IPosPrinterEvent() {
            @Override
            public void onPrintStarted() {}

            @Override
            public void onPrinterError(String error, boolean isPaperError) {}

            @Override
            public void onPrintEnd() {}
          }
        );
      } catch (Exception e) {
        e.printStackTrace();
      }
      return null;
    }
  }

  public Bitmap generateArrivalBitmap(
    String entryDate,
    String entryHour,
    Bitmap qrImage,
    Bitmap plateImage,
    String parkingPhone,
    String parkingName,
    String parkingAddress
  ) throws Exception {
    PaxGLPage iPaxGLPage = PaxGLPage.getInstance(appContext);
    IPage page = iPaxGLPage.createPage();

    page.setTypefaceObj(persianFont);
    page
      .addLine()
      .addUnit(
        getImageFromAssetsFile("parking-receipt.bmp"),
        IPage.EAlign.CENTER
      );
    page
      .addLine()
      .addUnit(
        parkingName,
        32,
        IPage.EAlign.CENTER,
        IPage.ILine.IUnit.TEXT_STYLE_BOLD
      )
      .adjustTopSpace(10);
    page
      .addLine()
      .addUnit(
        "---------------------------------------------------------",
        FONT_NORMAL,
        IPage.EAlign.CENTER
      )
      .adjustTopSpace(8);
    page
      .addLine()
      .addUnit(parkingAddress, FONT_NORMAL, IPage.EAlign.CENTER)
      .adjustTopSpace(1);
    page
      .addLine()
      .addUnit(parkingPhone, FONT_NORMAL, IPage.EAlign.CENTER)
      .adjustTopSpace(0);
    page
      .addLine()
      .addUnit(
        "---------------------------------------------------------",
        FONT_NORMAL,
        IPage.EAlign.CENTER
      )
      .adjustTopSpace(8);
    page.addLine().addUnit("ورود:", 26, IPage.EAlign.CENTER).adjustTopSpace(1);
    page
      .addLine()
      .addUnit(entryDate, FONT_NORMAL, IPage.EAlign.LEFT)
      .addUnit(entryHour, FONT_NORMAL, IPage.EAlign.RIGHT)
      .adjustTopSpace(0);
    page
      .addLine()
      .addUnit(
        "---------------------------------------------------------",
        FONT_NORMAL,
        IPage.EAlign.CENTER
      )
      .adjustTopSpace(8);
    page.addLine().addUnit(plateImage, IPage.EAlign.CENTER).adjustTopSpace(1);
    page
      .addLine()
      .addUnit(
        "---------------------------------------------------------",
        FONT_NORMAL,
        IPage.EAlign.CENTER
      )
      .adjustTopSpace(8);
    page.addLine().addUnit(qrImage, IPage.EAlign.CENTER).adjustTopSpace(1);
    page
      .addLine()
      .addUnit(
        "مجری طرح: شرکت مهندسی آراد با همکاری شهرداری اصفهان",
        20,
        IPage.EAlign.CENTER
      )
      .adjustTopSpace(20);
    page.addLine().addUnit(" ", FONT_NORMAL, IPage.EAlign.CENTER);
    page.addLine().addUnit(" ", FONT_NORMAL, IPage.EAlign.CENTER);
    page.addLine().addUnit(" ", FONT_NORMAL, IPage.EAlign.CENTER);
    page.addLine().addUnit(" ", FONT_NORMAL, IPage.EAlign.CENTER);

    int width = 384;
    Bitmap bitmap = iPaxGLPage.pageToBitmap(page, width);

    return bitmap;
  }

  public Bitmap getImageFromAssetsFile(String fileName) {
    Bitmap image = null;
    AssetManager assetManager = appContext.getAssets();
    try {
      InputStream is = assetManager.open(fileName);
      image = BitmapFactory.decodeStream(is);
      is.close();
    } catch (IOException e) {
      e.printStackTrace();
    }
    return image;
  }

  public Bitmap generateExitBitmap(
    String exitDate,
    String entryDate,
    String entryHour,
    String exitHour,
    Bitmap plate,
    String totalAmount,
    String paymentStatus,
    String parkingPhone,
    String parkingName,
    String parkingAddress,
    String totalParkTime
  ) throws Exception {
    PaxGLPage iPaxGLPage = PaxGLPage.getInstance(appContext);
    IPage page = iPaxGLPage.createPage();

    page.setTypefaceObj(persianFont);

    page.setTypefaceObj(persianFont);
    page
      .addLine()
      .addUnit(
        getImageFromAssetsFile("parking-receipt.bmp"),
        IPage.EAlign.CENTER
      );
    page
      .addLine()
      .addUnit(
        parkingName,
        32,
        IPage.EAlign.CENTER,
        IPage.ILine.IUnit.TEXT_STYLE_BOLD
      )
      .adjustTopSpace(0);
    page
      .addLine()
      .addUnit(
        "---------------------------------------------------------",
        FONT_NORMAL,
        IPage.EAlign.CENTER
      )
      .adjustTopSpace(0);
    page
      .addLine()
      .addUnit(parkingAddress, FONT_NORMAL, IPage.EAlign.CENTER)
      .adjustTopSpace(0);
    page
      .addLine()
      .addUnit(parkingPhone, FONT_NORMAL, IPage.EAlign.CENTER)
      .adjustTopSpace(0);
    page
      .addLine()
      .addUnit(
        "---------------------------------------------------------",
        FONT_NORMAL,
        IPage.EAlign.CENTER
      )
      .adjustTopSpace(0);
    page
      .addLine()
      .addUnit("ورود", 26, IPage.EAlign.LEFT)
      .addUnit(" ", 26, IPage.EAlign.CENTER)
      .addUnit("خروج", 26, IPage.EAlign.RIGHT)
      .adjustTopSpace(0);
    page
      .addLine()
      .addUnit(entryDate, FONT_NORMAL, IPage.EAlign.LEFT)
      .addUnit(exitDate, FONT_NORMAL, IPage.EAlign.RIGHT)
      .adjustTopSpace(0);
    page
      .addLine()
      .addUnit(entryHour, FONT_NORMAL, IPage.EAlign.LEFT)
      .addUnit(exitHour, FONT_NORMAL, IPage.EAlign.RIGHT)
      .adjustTopSpace(0);
    page
      .addLine()
      .addUnit(
        "---------------------------------------------------------",
        FONT_NORMAL,
        IPage.EAlign.CENTER
      )
      .adjustTopSpace(0);

    page
      .addLine()
      .addUnit(totalParkTime, FONT_NORMAL, IPage.EAlign.LEFT)
      .addUnit(" ", 26, IPage.EAlign.CENTER)
      .addUnit("مدت توقف", FONT_NORMAL, IPage.EAlign.RIGHT)
      .adjustTopSpace(0);
    page
      .addLine()
      .addUnit(totalAmount, FONT_NORMAL, IPage.EAlign.LEFT)
      .addUnit(" ", 26, IPage.EAlign.CENTER)
      .addUnit("مبلغ (ریال):", FONT_NORMAL, IPage.EAlign.RIGHT)
      .adjustTopSpace(0);

    page
      .addLine()
      .addUnit(
        "---------------------------------------------------------",
        FONT_NORMAL,
        IPage.EAlign.CENTER
      )
      .adjustTopSpace(0);

    page.addLine().addUnit(plate, IPage.EAlign.CENTER).adjustTopSpace(0);
    page
      .addLine()
      .addUnit(
        "---------------------------------------------------------",
        FONT_NORMAL,
        IPage.EAlign.CENTER
      )
      .adjustTopSpace(0);
    page
      .addLine()
      .addUnit(paymentStatus, 20, IPage.EAlign.CENTER)
      .adjustTopSpace(0);
    page
      .addLine()
      .addUnit(
        "مجری طرح: شرکت مهندسی آراد با همکاری شهرداری اصفهان",
        20,
        IPage.EAlign.CENTER
      )
      .adjustTopSpace(0);
    page.addLine().addUnit(" ", FONT_NORMAL, IPage.EAlign.CENTER);
    page.addLine().addUnit(" ", FONT_NORMAL, IPage.EAlign.CENTER);
    page.addLine().addUnit(" ", FONT_NORMAL, IPage.EAlign.CENTER);
    page.addLine().addUnit(" ", FONT_NORMAL, IPage.EAlign.CENTER);

    int width = 384;
    Bitmap bitmap = iPaxGLPage.pageToBitmap(page, width);

    return bitmap;
  }

  public Bitmap generateMarginalParkPaymentBitmap(
    Bitmap plate,
    String totalAmount,
    String totalParkTime,
    String paymentStatus,
    String submitDateTime
  ) throws Exception {
    PaxGLPage iPaxGLPage = PaxGLPage.getInstance(appContext);
    IPage page = iPaxGLPage.createPage();

    page.setTypefaceObj(persianFont);

    page
      .addLine()
      .addUnit(
        getImageFromAssetsFile("parking-receipt.bmp"),
        IPage.EAlign.CENTER
      );

    page.addLine().adjustTopSpace(26);

    page
      .addLine()
      .addUnit(submitDateTime, FONT_SMALL, IPage.EAlign.LEFT)
      .addUnit("زمان ثبت:            ", FONT_SMALL, IPage.EAlign.RIGHT)
      .adjustTopSpace(13);

    page
      .addLine()
      .addUnit(totalParkTime, FONT_SMALL, IPage.EAlign.LEFT)
      .addUnit("مدت پارک:            ", FONT_SMALL, IPage.EAlign.RIGHT)
      .adjustTopSpace(0);
    page
      .addLine()
      .addUnit(totalAmount, FONT_SMALL, IPage.EAlign.LEFT)
      .addUnit("مبلغ (ریال):            ", FONT_SMALL, IPage.EAlign.RIGHT)
      .adjustTopSpace(0);

    page.addLine().addUnit(plate, IPage.EAlign.CENTER).adjustTopSpace(26);

    page
      .addLine()
      .addUnit(paymentStatus, 20, IPage.EAlign.CENTER)
      .adjustTopSpace(26);

    page
      .addLine()
      .addUnit(
        "مجری:‌شرکت مهندسی آراد با همکاری شهرداری اصفهان",
        16,
        IPage.EAlign.CENTER
      )
      .adjustTopSpace(0);

    page.addLine().addUnit(" ", FONT_NORMAL, IPage.EAlign.CENTER);

    page.addLine().addUnit(" ", FONT_NORMAL, IPage.EAlign.CENTER);

    page.addLine().addUnit(" ", FONT_NORMAL, IPage.EAlign.CENTER);

    page.addLine().addUnit(" ", FONT_NORMAL, IPage.EAlign.CENTER);

    int width = 384;
    Bitmap bitmap = iPaxGLPage.pageToBitmap(page, width);

    return bitmap;
  }
}
