package com.mirasense.scanditsdk.plugin;

import android.content.pm.ActivityInfo;
import android.os.Bundle;
import android.util.Log;
import android.view.Window;
import android.view.WindowManager;
import com.mirasense.scanditsdk.LegacyPortraitScanditSDKBarcodePicker;
import com.mirasense.scanditsdk.ScanditSDKBarcodePicker;
import com.mirasense.scanditsdk.ScanditSDKScanSettings;
import com.mirasense.scanditsdk.interfaces.*;
import com.mirasense.scanditsdk.interfaces.ScanditSDK;
import com.mirasense.scanditsdk.internal.ScanditSDKGlobals;

/**
 * Created by mo on 10/06/15.
 */
public class ScanditSDKParameterParser {

    public static ScanditSDKScanSettings settingsForBundle(Bundle bundle) {

        ScanditSDKScanSettings settings = ScanditSDKScanSettings.getDefaultSettings();

        int facing = ScanditSDK.CAMERA_FACING_BACK;
        if (bundle.containsKey("preferFrontCamera") && bundle.getBoolean("preferFrontCamera")) {
            facing = ScanditSDK.CAMERA_FACING_FRONT;
        }
        settings.setCameraFacingPreference(facing);

        if (bundle.containsKey("1DScanning") && bundle.getBoolean("1DScanning")) {
            Log.e("ScanditSDK", "The parameter '1DScanning' is deprecated. Please enable symbologies individually instead");
            settings.enableSymbologies(new ScanditSDK.Symbology[]{
                    ScanditSDK.Symbology.EAN13, ScanditSDK.Symbology.UPC12, ScanditSDK.Symbology.EAN8,
                    ScanditSDK.Symbology.CODE128, ScanditSDK.Symbology.CODE39, ScanditSDK.Symbology.CODE93,
                    ScanditSDK.Symbology.ITF, ScanditSDK.Symbology.MSI_PLESSEY, ScanditSDK.Symbology.UPCE,
                    ScanditSDK.Symbology.CODABAR, ScanditSDK.Symbology.GS1_DATABAR,
                    ScanditSDK.Symbology.GS1_DATABAR_EXPANDED});
        }
        if (bundle.containsKey("2DScanning") && bundle.getBoolean("2DScanning")) {
            Log.e("ScanditSDK", "The parameter '2DScanning' is deprecated. Please enable symbologies individually instead");
            settings.enableSymbologies(new ScanditSDK.Symbology[]{
                    ScanditSDK.Symbology.AZTEC, ScanditSDK.Symbology.DATAMATRIX, ScanditSDK.Symbology.PDF417,
                    ScanditSDK.Symbology.QR});
        }

        if ((bundle.containsKey("ean13AndUpc12") && bundle.getBoolean("ean13AndUpc12"))
                || !bundle.containsKey("ean13AndUpc12")) {
            //Log.e("ScanditSDK", "The parameter 'ean13AndUpc12' is deprecated. Please enable the symbologies individually instead");
            settings.enableSymbology(ScanditSDK.Symbology.EAN13);
            settings.enableSymbology(ScanditSDK.Symbology.UPC12);
        }
        if ((bundle.containsKey("ean8") && bundle.getBoolean("ean8"))
                || !bundle.containsKey("ean8")) {
            settings.enableSymbology(ScanditSDK.Symbology.EAN8);
        }
        if ((bundle.containsKey("upce") && bundle.getBoolean("upce"))
                || !bundle.containsKey("upce")) {
            settings.enableSymbology(ScanditSDK.Symbology.UPCE);
        }
        if ((bundle.containsKey("code39") && bundle.getBoolean("code39"))
                || !bundle.containsKey("code93")) {
            settings.enableSymbology(ScanditSDK.Symbology.CODE39);
        }
        if ((bundle.containsKey("code93") && bundle.getBoolean("code93"))
                || !bundle.containsKey("code93")) {
            settings.enableSymbology(ScanditSDK.Symbology.CODE93);
        }
        if ((bundle.containsKey("code128") && bundle.getBoolean("code128"))
                || !bundle.containsKey("code128")) {
            settings.enableSymbology(ScanditSDK.Symbology.CODE128);
        }
        if (bundle.containsKey("itf") && bundle.getBoolean("itf")) {
            settings.enableSymbology(ScanditSDK.Symbology.ITF);
        }
        if (bundle.containsKey("gs1DataBar") && bundle.getBoolean("gs1DataBar")) {
            settings.enableSymbology(ScanditSDK.Symbology.GS1_DATABAR);
        }
        if (bundle.containsKey("gs1DataBarExpanded") && bundle.getBoolean("gs1DataBarExpanded")) {
            settings.enableSymbology(ScanditSDK.Symbology.GS1_DATABAR_EXPANDED);
        }
        if (bundle.containsKey("codabar") && bundle.getBoolean("codabar")) {
            settings.enableSymbology(ScanditSDK.Symbology.CODABAR);
        }
        if ((bundle.containsKey("qr") && bundle.getBoolean("qr"))
                || !bundle.containsKey("qr")) {
            settings.enableSymbology(ScanditSDK.Symbology.QR);
        }
        if ((bundle.containsKey("dataMatrix") && bundle.getBoolean("dataMatrix"))
                || !bundle.containsKey("dataMatrix")) {
            settings.enableSymbology(ScanditSDK.Symbology.DATAMATRIX);
        }
        if (bundle.containsKey("pdf417") && bundle.getBoolean("pdf417")) {
            settings.enableSymbology(ScanditSDK.Symbology.PDF417);
        }
        if (bundle.containsKey("aztec") && bundle.getBoolean("aztec")) {
            settings.enableSymbology(ScanditSDK.Symbology.AZTEC);
        }
        if (bundle.containsKey("msiPlessey") && bundle.getBoolean("msiPlessey")) {
            settings.enableSymbology(ScanditSDK.Symbology.MSI_PLESSEY);
        }
        if (bundle.containsKey("msiPlesseyChecksumType")) {
            String checksum = bundle.getString("msiPlesseyChecksumType");
            int actualChecksum = com.mirasense.scanditsdk.interfaces.ScanditSDK.CHECKSUM_MOD_10;
            if (checksum.equals("none")) {
                actualChecksum = com.mirasense.scanditsdk.interfaces.ScanditSDK.CHECKSUM_NONE;
            } else if (checksum.equals("mod11")) {
                actualChecksum = com.mirasense.scanditsdk.interfaces.ScanditSDK.CHECKSUM_MOD_11;
            } else if (checksum.equals("mod1010")) {
                actualChecksum = com.mirasense.scanditsdk.interfaces.ScanditSDK.CHECKSUM_MOD_1010;
            } else if (checksum.equals("mod1110")) {
                actualChecksum = com.mirasense.scanditsdk.interfaces.ScanditSDK.CHECKSUM_MOD_1110;
            }
            settings.setMsiPlesseyChecksumType(actualChecksum);
        }

        if (bundle.containsKey("inverseRecognition")) {
            settings.enableColorInverted2dRecognition(bundle.getBoolean("inverseRecognition"));
        }
        if (bundle.containsKey("microDataMatrix")) {
            settings.enableMicroDataMatrix(bundle.getBoolean("microDataMatrix"));
        }

        if (bundle.containsKey("force2d")) {
            settings.force2dRecognition(bundle.getBoolean("force2d"));
        }

        if (bundle.containsKey("scanningHotSpot")) {
            String hotspot = bundle.getString("scanningHotSpot");
            String[] split = hotspot.split("[/]");
            if (split.length == 2) {
                try {
                    Float x = Float.valueOf(split[0]);
                    Float y = Float.valueOf(split[1]);
                    settings.setScanningHotSpot(x, y);
                } catch (NumberFormatException e) {}
            }
        }

        if (bundle.containsKey("scanningHotspotHeight")) {
            settings.setScanningHotSpotHeight(bundle.getFloat("scanningHotspotHeight"));
        }

        return settings;
    }

    public static void updatePickerUIFromBundle(ScanditSDK picker, Bundle bundle) {
        if (bundle.containsKey("searchBar")) {
            picker.getOverlayView().showSearchBar(bundle.getBoolean("searchBar"));
        }
        if (bundle.containsKey("beep")) {
            picker.getOverlayView().setBeepEnabled(bundle.getBoolean("beep"));
        }
        if (bundle.containsKey("vibrate")) {
            picker.getOverlayView().setVibrateEnabled(bundle.getBoolean("vibrate"));
        }
        if (bundle.containsKey("torch")) {
            picker.getOverlayView().setTorchEnabled(bundle.getBoolean("torch"));
        }
        if (bundle.containsKey("torchButtonPositionAndSize")) {
            String hotspot = bundle.getString("torchButtonPositionAndSize");
            String[] split = hotspot.split("[/]");
            if (split.length == 4) {
                try {
                    Float x = Float.valueOf(split[0]);
                    Float y = Float.valueOf(split[1]);
                    int width = Integer.valueOf(split[2]);
                    int height = Integer.valueOf(split[3]);
                    picker.getOverlayView().setTorchButtonPosition(x, y, width, height);
                } catch (NumberFormatException e) {}
            }
        }

        if (bundle.containsKey("cameraSwitchVisibility")) {
            String visibility = bundle.getString("cameraSwitchVisibility");
            int actualVisibility = ScanditSDKOverlay.CAMERA_SWITCH_NEVER;
            if (visibility.equals("tablet")) {
                actualVisibility = ScanditSDKOverlay.CAMERA_SWITCH_ON_TABLET;
            } else if (visibility.equals("always")) {
                actualVisibility = ScanditSDKOverlay.CAMERA_SWITCH_ALWAYS;
            }
            picker.getOverlayView().setCameraSwitchVisibility(actualVisibility);
        }
        if (bundle.containsKey("cameraSwitchButtonPositionAndSize")) {
            String hotspot = bundle.getString("cameraSwitchButtonPositionAndSize");
            String[] split = hotspot.split("[/]");
            if (split.length == 4) {
                try {
                    Float x = Float.valueOf(split[0]);
                    Float y = Float.valueOf(split[1]);
                    int width = Integer.valueOf(split[2]);
                    int height = Integer.valueOf(split[3]);
                    picker.getOverlayView().setCameraSwitchButtonPosition(
                            x, y, width, height);
                } catch (NumberFormatException e) {}
            }
        }

        if (bundle.containsKey("textForInitialScanScreenState")) {
            picker.getOverlayView().setTextForInitialScanScreenState(
                    bundle.getString("textForInitialScanScreenState"));
        }
        if (bundle.containsKey("textForBarcodePresenceDetected")) {
            picker.getOverlayView().setTextForBarcodePresenceDetected(
                    bundle.getString("textForBarcodePresenceDetected"));
        }
        if (bundle.containsKey("textForBarcodeDecodingInProgress")) {
            picker.getOverlayView().setTextForBarcodeDecodingInProgress(
                    bundle.getString("textForBarcodeDecodingInProgress"));
        }
        if (bundle.containsKey("titleMessage")) {
            picker.getOverlayView().setTitleMessage(
                    bundle.getString("titleMessage"));
        }
        if (bundle.containsKey("leftButtonCaption")) {
            picker.getOverlayView().setLeftButtonCaption(
                    bundle.getString("leftButtonCaption"));
        }
        if (bundle.containsKey("leftButtonCaptionWhenKeypadVisible")) {
            picker.getOverlayView().setLeftButtonCaptionWhenKeypadVisible(
                    bundle.getString("leftButtonCaptionWhenKeypadVisible"));
        }
        if (bundle.containsKey("rightButtonCaption")) {
            picker.getOverlayView().setRightButtonCaption(
                    bundle.getString("rightButtonCaption"));
        }
        if (bundle.containsKey("rightButtonCaptionWhenKeypadVisible")) {
            picker.getOverlayView().setRightButtonCaptionWhenKeypadVisible(
                    bundle.getString("rightButtonCaptionWhenKeypadVisible"));
        }
        if (bundle.containsKey("setSearchBarPlaceholderText")) {
            picker.getOverlayView().setSearchBarPlaceholderText(
                    bundle.getString("setSearchBarPlaceholderText"));
        }

        if (bundle.containsKey("viewfinderDimension")) {
            String hotspot = bundle.getString("viewfinderDimension");
            String[] split = hotspot.split("[/]");
            if (split.length == 2) {
                try {
                    Float width = Float.valueOf(split[0]);
                    Float height = Float.valueOf(split[1]);
                    picker.getOverlayView().setViewfinderDimension(width, height);
                } catch (NumberFormatException e) {}
            } else if (split.length == 4) {
                try {
                    Float width = Float.valueOf(split[0]);
                    Float height = Float.valueOf(split[1]);
                    Float landscapeWidth = Float.valueOf(split[2]);
                    Float landscapeHeight = Float.valueOf(split[3]);
                    picker.getOverlayView().setViewfinderDimension(
                            width, height, landscapeWidth, landscapeHeight);
                } catch (NumberFormatException e) {}
            }
        }

        if (bundle.containsKey("viewfinderSize")) {
            String hotspot = bundle.getString("viewfinderSize");
            String[] split = hotspot.split("[/]");
            if (split.length == 2) {
                try {
                    Float width = Float.valueOf(split[0]);
                    Float height = Float.valueOf(split[1]);
                    picker.getOverlayView().setViewfinderDimension(width, height);
                } catch (NumberFormatException e) {}
            } else if (split.length == 4) {
                try {
                    Float width = Float.valueOf(split[0]);
                    Float height = Float.valueOf(split[1]);
                    Float landscapeWidth = Float.valueOf(split[2]);
                    Float landscapeHeight = Float.valueOf(split[3]);
                    picker.getOverlayView().setViewfinderDimension(
                            width, height, landscapeWidth, landscapeHeight);
                } catch (NumberFormatException e) {}
            }
        }

        if (bundle.containsKey("viewfinderTextHook")) {
            picker.getOverlayView().drawViewfinderTextHook(
                    bundle.getBoolean("viewfinderTextHook"));
        }
        if (bundle.containsKey("viewfinderColor")) {
            String color = bundle.getString("viewfinderColor");
            if (color.length() == 6) {
                try {
                    String red = color.substring(0, 2);
                    String green = color.substring(2, 4);
                    String blue = color.substring(4, 6);
                    float r = ((float) Integer.parseInt(red, 16)) / 256.0f;
                    float g = ((float) Integer.parseInt(green, 16)) / 256.0f;
                    float b = ((float) Integer.parseInt(blue, 16)) / 256.0f;
                    picker.getOverlayView().setViewfinderColor(r, g, b);
                } catch (NumberFormatException e) {}
            }
        }
        if (bundle.containsKey("viewfinderDecodedColor")) {
            String color = bundle.getString("viewfinderDecodedColor");
            if (color.length() == 6) {
                try {
                    String red = color.substring(0, 2);
                    String green = color.substring(2, 4);
                    String blue = color.substring(4, 6);
                    float r = ((float) Integer.parseInt(red, 16)) / 256.0f;
                    float g = ((float) Integer.parseInt(green, 16)) / 256.0f;
                    float b = ((float) Integer.parseInt(blue, 16)) / 256.0f;
                    picker.getOverlayView().setViewfinderDecodedColor(r, g, b);
                } catch (NumberFormatException e) {}
            }
        }
        if (bundle.containsKey("logoOffsets")) {
            String offsets = bundle.getString("logoOffsets");
            String[] split = offsets.split("[,]");
            if (split.length == 4) {
                try {
                    Float xOffset = Float.valueOf(split[0].trim());
                    Float yOffset = Float.valueOf(split[1].trim());
                    Float landscapeXOffset = Float.valueOf(split[2].trim());
                    Float landscapeYOffset = Float.valueOf(split[3].trim());
                    picker.getOverlayView().setViewfinderDimension(
                            xOffset, yOffset, landscapeXOffset, landscapeYOffset);
                } catch (NumberFormatException e) {}
            }
        }
        if (bundle.containsKey("zoom")) {
            picker.setZoom(bundle.getFloat("zoom"));
        }
    }
}
