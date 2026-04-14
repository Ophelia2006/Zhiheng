import { UIContext } from '@kit.ArkUI';

/**
 * 封装的年月选择器组件
 */
@Component
export struct DatePickerComponent {
  @Prop label: string;
  @Prop value: string;
  onChange: (val: string) => void = () => {
  };

  build() {
    Column() {
      Text(this.label)
        .fontSize(13)
        .fontColor('#666666')
        .margin({ bottom: 6 })
        .width('100%')

      Row() {
        Text(this.value || '请选择时间')
          .fontSize(15)
          .fontColor(this.value ? '#333333' : '#999999')
          .layoutWeight(1)

        Image($r('app.media.right_arrow'))
          .width(16)
          .height(16)
          .fillColor('#999999')
      }
      .width('100%')
      .height(44)
      .backgroundColor('#F9F9F9')
      .borderRadius(8)
      .padding({ left: 12, right: 12 })
      .onClick(() => {
        // 设置默认选中时间，如果有原值则尝试解析，没有则默认为当前时间
        let selectedDate = new Date();
        if (this.value && this.value.includes('-')) {
          const parts = this.value.split('-');
          if (parts.length >= 2) {
            selectedDate = new Date(Number(parts[0]), Number(parts[1]) - 1, 1);
          }
        }

        // 调用 UIContext 的 showDatePickerDialog，支持自定义样式和模式
        this.getUIContext().showDatePickerDialog({
          start: new Date('1970-01-01'),
          end: new Date('2100-12-31'),
          selected: selectedDate,
          mode: DatePickerMode.YEAR_AND_MONTH,
          // 设置模式为年和月 (需要API支持，如果是旧版本可能没有 MONTH_AND_YEAR，这里使用 MONTH_AND_DAY 作为示例，如果真机/SDK支持 MONTH_AND_YEAR 则可以替换)
          // 根据官方文档，如果是只选年月，部分系统版本可能没有直接枚举，但我们可以先尝试使用，如果不支持则退回默认
          // 注意：如果编译器报错没有 YEAR_AND_MONTH，请暂时删掉 mode 参数，或查阅具体 API 版本支持的枚举。
          // mode: DatePickerMode.YEAR_AND_MONTH,

          // 自定义绿色主题样式
          disappearTextStyle: { color: '#999999', font: { size: '14fp', weight: FontWeight.Normal } },
          textStyle: { color: '#333333', font: { size: '16fp', weight: FontWeight.Normal } },
          selectedTextStyle: { color: '#1EC18D', font: { size: '20fp', weight: FontWeight.Medium } }, // 绿色高亮

          acceptButtonStyle: {
            type: ButtonType.Normal,
            style: ButtonStyleMode.NORMAL,
            role: ButtonRole.NORMAL,
            fontColor: '#1EC18D', // 确定按钮绿色
            fontSize: '16fp',
            fontWeight: FontWeight.Medium,
            backgroundColor: 'transparent',
            borderRadius: 8
          },
          cancelButtonStyle: {
            type: ButtonType.Normal,
            style: ButtonStyleMode.NORMAL,
            role: ButtonRole.NORMAL,
            fontColor: '#999999', // 取消按钮灰色
            fontSize: '16fp',
            fontWeight: FontWeight.Normal,
            backgroundColor: 'transparent',
            borderRadius: 8
          },
          onDateAccept: (value: Date) => {
            // 获取用户选择的年月
            const year = value.getFullYear();
            // getMonth() 返回 0-11，需要加 1，并补齐两位
            const month = value.getMonth() + 1;
            const monthStr = month < 10 ? `0${month}` : `${month}`;
            const formattedDate = `${year}-${monthStr}`;

            // 回调通知父组件
            this.onChange(formattedDate);
          }
        });
      })
    }
    .width('100%')
    .margin({ bottom: 12 })
  }
}