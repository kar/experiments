package gs.kar.buckexp

import android.app.Activity;
import android.os.Bundle;
import android.widget.Toast
import gs.kar.android.R

/**
 * MainActivity is the entrypoint to the app.
 */
public class MainActivity : Activity() {
  override public fun onCreate(b: Bundle?) {
    super.onCreate(b)
    Toast.makeText(this, R.string.app_name, Toast.LENGTH_LONG).show()
  }
}
