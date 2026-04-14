import { RadarChart, RadarChartModel, RadarData, RadarDataSet, RadarEntry, XAxis, YAxis, Legend, IAxisValueFormatter, AxisBase, YAxisLabelPosition, Description, JArrayList } from '@ohos/mpchart';
import { RadarData as ModelRadarData } from '@ohos/model/src/main/ets/InterviewReport';

// 自定义 X 轴标签格式化器
class RadarXAxisValueFormatter implements IAxisValueFormatter {
  private labels: string[] = ['准确性', '完整性', '表达能力', '逻辑能力', '详细程度'];

  getFormattedValue(value: number, axis: AxisBase): string {
    return this.labels[value % this.labels.length];
  }
}

// 自定义 Y 轴标签格式化器
class RadarYAxisValueFormatter implements IAxisValueFormatter {
  getFormattedValue(value: number, axis: AxisBase): string {
    return String(Math.floor(value));
  }
}

@Component
export struct RadarChartComponent {
  // 从父组件接收数据
  @Prop radarData: ModelRadarData | null = null;
  
  // 图表模型对象
  private model: RadarChartModel = new RadarChartModel();

  aboutToAppear() {
    this.initChart();
  }

  // 监听数据变化，动态更新图表
  aboutToComponentBuild() {
    this.initChart();
  }

  private initChart() {
    if (!this.radarData) return;

    // 1. 创建数据条目 (按照 labels 的顺序: 准确性, 完整性, 表达能力, 逻辑能力, 详细程度)
    // 注意：mpchart 要求使用 JArrayList 而不是原生的 TypeScript 数组
    let entries: JArrayList<RadarEntry> = new JArrayList<RadarEntry>();
    entries.add(new RadarEntry(this.radarData.accuracyScore));
    entries.add(new RadarEntry(this.radarData.completenessScore));
    entries.add(new RadarEntry(this.radarData.expressionAbilityScore));
    entries.add(new RadarEntry(this.radarData.logicScore));
    entries.add(new RadarEntry(this.radarData.levelOfDetailScore));

    // 2. 创建数据集并设置样式
    let dataSet = new RadarDataSet(entries, "能力评估");
    dataSet.setColorByColor(Color.Green);          // 边框颜色
    dataSet.setFillColor(Color.Green);      // 填充颜色
    dataSet.setDrawFilled(true);            // 允许填充
    dataSet.setFillAlpha(50);               // 填充透明度
    dataSet.setLineWidth(2);                // 边框粗细
    dataSet.setDrawHighlightCircleEnabled(true);
    dataSet.setDrawHighlightIndicators(false);

    // 3. 将数据集绑定到模型
    let dataSets: JArrayList<RadarDataSet> = new JArrayList<RadarDataSet>();
    dataSets.add(dataSet);
    
    let chartData = new RadarData(dataSets);
    
    // 设置数据前，先设置好各种轴的属性
    this.setupChartProperties();
    
    this.model.setData(chartData);
    
    // 注意：动画必须在 setData 之后调用，并且参数单位是毫秒(ms)
    // 这里设置 1400 毫秒（1.4秒）的动画时长
    // this.model.animateXY(700, 700);
    this.model.animateY(400);

    this.model.invalidate(); // 刷新图表
  }

  private setupChartProperties() {
    // 隐藏描述文字
    let description: Description | null = this.model.getDescription();
    if (description) {
      description.setEnabled(false);
    }

    // 设置图表内边距，防止标签被裁剪
    this.model.setExtraOffsets(20, 20, 20, 20);

    // 设置 Web 线的颜色和粗细 (蜘蛛网)
    this.model.setWebLineWidth(1);
    this.model.setWebColor(0xcccccc);
    this.model.setWebLineWidthInner(1);
    this.model.setWebColorInner(0xcccccc);
    this.model.setWebAlpha(100);

    // 设置 X 轴 (外围标签)
    let xAxis: XAxis | null = this.model.getXAxis();
    if (xAxis) {
      xAxis.setTextSize(12);
      xAxis.setYOffset(0);
      xAxis.setXOffset(0);
      xAxis.setValueFormatter(new RadarXAxisValueFormatter());
      xAxis.setTextColor(0x333333);
    }

    // 设置 Y 轴 (刻度线)
    let yAxis: YAxis | null = this.model.getYAxis();
    if (yAxis) {
      yAxis.setLabelCount(5, false);
      yAxis.setTextSize(10);
      yAxis.setAxisMinimum(0);    // 最小值
      yAxis.setAxisMaximum(15);  // 最大值
      yAxis.setDrawLabels(false); // 不显示具体的刻度数字，显得更干净
    }

    // 设置图例
    let legend: Legend | null = this.model.getLegend();
    if (legend) {
      legend.setEnabled(false); // 隐藏默认图例
    }
  }

  build() {
    Column() {
      // 渲染第三方库的雷达图组件
      RadarChart({ model: this.model })
        .width('100%')
        .height(300)
    }
    .width('100%')
    .padding(10)
  }
}
