package org.gnaadan;

import android.content.Context;
import android.os.Build;
import android.os.VibrationEffect;
import android.os.Vibrator;

public class AndroidExtras {

    public AndroidExtras(){}

    public static boolean vibrate(Context context, int duration_ms){

        boolean vibrated=false;
        Vibrator v;
        v = (Vibrator) context.getSystemService(Context.VIBRATOR_SERVICE);
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            v.vibrate(VibrationEffect.createOneShot(duration_ms, VibrationEffect.DEFAULT_AMPLITUDE));
            vibrated = true;
        } else {
            v.vibrate(duration_ms);
            vibrated = true;
        }
        return vibrated;

    }

}
