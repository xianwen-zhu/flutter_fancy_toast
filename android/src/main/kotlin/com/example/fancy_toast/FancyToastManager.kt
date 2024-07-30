//
//  FancyToastManager.kt
//  fancy_toast
//
//  Created by 朱先文 on 2024/7/27.
//

package com.example.fancytoast

import android.app.Activity
import android.app.Dialog
import android.content.Context
import android.view.Gravity
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ImageView
import android.widget.TextView
import android.widget.Toast
import com.bumptech.glide.Glide
import com.example.fancy_toast.R

class FancyToastManager private constructor() {

    private var currentToast: Toast? = null
    private var currentDialog: Dialog? = null

    companion object {
        val instance: FancyToastManager by lazy { FancyToastManager() }
    }

    fun showToast(context: Context, message: String) {
        dismissActiveToast()
        val inflater = LayoutInflater.from(context)
        val layout: View = inflater.inflate(R.layout.toast_text, null)

        val text: TextView = layout.findViewById(R.id.toast_message)
        text.text = message

        val maxWidth = context.resources.displayMetrics.widthPixels - 80
        val labelSize = measureTextSize(text, message, maxWidth)
        val toastWidth = maxOf(96, labelSize.first + 40)
        val toastHeight = labelSize.second + 28

        layout.layoutParams = ViewGroup.LayoutParams(toastWidth, toastHeight)

        currentToast = Toast(context).apply {
            duration = Toast.LENGTH_SHORT
            view = layout
            setGravity(Gravity.CENTER, 0, 0)
            show()
        }
    }

    fun showIconToast(context: Context, message: String, style: ToastStyle) {
        dismissActiveToast()

        val inflater = LayoutInflater.from(context)
        val layout: View = inflater.inflate(R.layout.toast_icon, null)

        val iconRes = when (style) {
            ToastStyle.SUCCESS -> R.drawable.icon_success
            ToastStyle.ERROR -> R.drawable.icon_error
            ToastStyle.WARNING -> R.drawable.icon_warning
        }

        layout.findViewById<ImageView>(R.id.toast_icon).setImageResource(iconRes)
        layout.findViewById<TextView>(R.id.toast_message).text = message

        currentToast = Toast(context).apply {
            duration = Toast.LENGTH_SHORT
            view = layout
            setGravity(Gravity.CENTER, 0, 0)
            show()
        }
    }

    fun showLoading(context: Context, message: String) {
        dismissActiveToast() // 取消当前显示的Toast或Dialog（如果有的话）

        if (context !is Activity) {
            throw IllegalArgumentException("Context must be an Activity")
        }

        currentDialog = Dialog(context, R.style.FullScreenDialogStyle).apply {
            setContentView(R.layout.toast_loading)
            setCancelable(false) // 设置为不可取消
            window?.setLayout(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT)
            window?.setGravity(Gravity.CENTER)

            val gifImageView = findViewById<ImageView>(R.id.loading_image)
            Glide.with(context).asGif().load(R.drawable.loading_gif).into(gifImageView)

            findViewById<TextView>(R.id.loading_message).text = message
            show()
        }
    }

    fun dismissActiveToast() {
        currentToast?.cancel()
        currentDialog?.dismiss()
        currentToast = null
        currentDialog = null
    }

    private fun measureTextSize(textView: TextView, message: String, maxWidth: Int): Pair<Int, Int> {
        val measureWidthSpec = View.MeasureSpec.makeMeasureSpec(maxWidth, View.MeasureSpec.AT_MOST)
        val measureHeightSpec = View.MeasureSpec.makeMeasureSpec(0, View.MeasureSpec.UNSPECIFIED)

        textView.text = message
        textView.measure(measureWidthSpec, measureHeightSpec)
        return Pair(textView.measuredWidth, textView.measuredHeight)
    }

    enum class ToastStyle {
        SUCCESS, ERROR, WARNING
    }
}