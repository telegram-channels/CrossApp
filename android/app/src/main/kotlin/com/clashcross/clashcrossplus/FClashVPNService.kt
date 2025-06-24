package com.clashcross.clashcrossplus

import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.Service
import android.content.Context
import android.content.Intent
import android.net.ProxyInfo
import android.net.VpnService
import android.os.ParcelFileDescriptor
import android.util.Log
import androidx.core.app.NotificationCompat
import java.net.Socket

class FClashVPNService : VpnService() {

    companion object {
        const val TAG = "ClashCrossPlugin"
        const val CHANNEL = "ClashCrossVpn"

        enum class Action {
            StartProxy,
            StopProxy,
            SetHttpPort
        }
    }

    private var mFd: ParcelFileDescriptor? = null
    private var serverPort = 7890
        set(value) {
            field = value
        }

    override fun onCreate() {
        super.onCreate()
        Log.d(TAG, "creating fclash vpn service.")
        val channel = NotificationChannel(CHANNEL, "crazecloud", NotificationManager.IMPORTANCE_HIGH)
        (getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager).createNotificationChannel(channel)
        val notification = with(NotificationCompat.Builder(this, CHANNEL)) {
            // setContentTitle("Your Title")
            // setContentText("Your text")
            build()
        }
        startForeground(1, notification)
    }

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        intent?.let {
            when (it.action) {
                "start" -> {
                    startVpnService()
                    return START_STICKY
                }
                "stop" -> {
                    stopVpnService()
                    stopForeground(Service.STOP_FOREGROUND_REMOVE)
                    stopSelf()
                    return START_NOT_STICKY
                }
                Action.SetHttpPort.toString() -> {
                    val port = it.extras!!.getInt("port")
                    this.serverPort = port
                    if (mFd != null) {
                        stopVpnService()
                        startVpnService()
                    }
                }
                else -> {
                    return START_NOT_STICKY
                }
            }
        }
        return START_NOT_STICKY
    }

    override fun onDestroy() {
        stopVpnService()
        super.onDestroy()
    }

    private fun startVpnService() {
        mFd?.close()
        mFd = with(Builder()) {
            addAddress("10.0.0.2", 32)
            setMtu(1500)
            setHttpProxy(ProxyInfo.buildDirectProxy("127.0.0.1", serverPort))
            setSession("FClash服务")
            establish()
        }
        if (mFd == null) {
            Log.e("FClash", "Interface creation failed")
        }
    }

    private fun stopVpnService() {
        try {
            mFd?.close()
            Log.d(TAG, "fclash service stopped")
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }
}
