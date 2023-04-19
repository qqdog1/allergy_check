class Allergen {
  List<String> lst = [
    '牛奶',
    '羊奶',
    '起司',
    '優酪乳',
    '雞蛋',
    '鴨蛋',
    '豬肉',
    '雞肉',
    '鴨肉',
    '鵝肉',
    '牛肉',
    '羊肉',
    '蝦子',
    '蛤蠣',
    '螃蟹',
    '牡蠣',
    '扇貝',
    '鮭魚',
    '鱈魚',
    '鯖魚',
    '沙丁魚',
    '旗魚',
    '鰻魚',
    '鮪魚',
    '虱目魚',
    '吳郭魚',
    '魷魚',
    '烏賊',
    '鯷魚',
    '鯡魚',
    '海藻',
    '海帶',
    '米',
    '小米',
    '燕麥',
    '蕎麥',
    '小麥',
    '大麥',
    '黑麥',
    '花生',
    '薏仁',
    '杏仁',
    '黃豆',
    '紅豆',
    '綠豆',
    '蠶豆',
    '腰果',
    '核桃',
    '芝麻',
    '開心果',
    '橄欖油',
    '菜籽油',
    '芝麻油',
    '蔬菜油',
    '大豆油',
    '亞麻仁油',
    '椰子油',
    '棕櫚油',
    '花生油',
    '牛油',
    '豬油',
    '白菜',
    '芹菜',
    '菠菜',
    '萵苣',
    '花椰菜',
    '油菜籽',
    '青椒',
    '茴香',
    '茄子',
    '蘑菇',
    '竹筍',
    '玉米',
    '番茄',
    '小黃瓜',
    '碗豆',
    '扁豆',
    '馬鈴薯',
    '胡蘿蔔',
    '南瓜',
    '山藥',
    '芋頭',
    '番薯',
    '洋蔥',
    '韭菜',
    '大蒜',
    '生薑',
    '葡萄',
    '蘋果',
    '香蕉',
    '哈密瓜',
    '甜瓜',
    '橘子',
    '柳橙',
    '葡萄柚',
    '奇異果',
    '草莓',
    '木瓜',
    '洋梨',
    '番石榴',
    '鳳梨',
    '椰子',
    '檸檬',
    '火龍果',
    '桑葚',
    '棗子',
    '桃子',
    '梅子',
    '柿子',
    '甘蔗',
    '荔枝',
    '芒果',
    '龍眼',
    '巧克力',
    '咖啡',
    '茶葉',
    '蜂蜜',
    '醣',
    '醋',
    '啤酒',
    '高粱',
    '麥芽',
    '香草',
    '薄荷',
    '芥末',
    '胡椒',
    '辣椒',
    '五香粉',
    '咖哩粉',
    '味精',
    '麵包酵母',
    '啤酒酵母',
    '貓',
    '狗',
    '老鼠',
    '兔子',
    '鳥',
    '馬',
    '牛',
    '跳蚤',
    '壁蝨',
    '恙蟲',
    '蚊子',
    '德國蟑螂',
    '蜘蛛',
    '螞蟻',
    '人毛屑',
    '貓毛屑',
    '狗毛屑',
    '鼠毛屑',
    '鴿毛屑',
    '牛毛屑',
    '馬毛屑',
    '羊毛屑',
    '安哥拉羊毛',
    '兔毛屑',
    '乳膠',
    '屋塵蹣',
    '粉塵蹣',
    '熱帶無爪蹣',
    '梅氏塵蹣',
    '腐食酪蹣',
    '白色念珠菌',
    '金黃色葡萄球菌',
    '中間鏈球菌',
    '青黴菌',
    '芽枝黴菌',
    '交錯黴菌',
    '煙色黴菌',
    '黃麴毒素',
    '木棉',
    '松樹',
    '尤加利樹',
    '相思樹',
    '白樺樹',
    '楓樹',
    '橡樹',
    '榆樹',
    '棉花',
    '早熟禾',
    '白扁柏',
    '桑樹',
    '牧草',
    '羊蹄草',
    '狗牙根草',
    '貓尾草',
    '艾草',
    '狐尾草',
    '防風草',
    '雛菊',
    '蒲公英',
    '苜蓿花粉',
    '莧菜花粉',
    '木蘭花',
    '忍冬花粉',
    '艾蒿花粉',
    '芒刺類雜草花粉',
    '鎘',
    '鉛',
    '鋁',
    '鈷',
    '鎳',
    '矽',
    '銀',
    '錫',
    '鈦',
    '汞',
    '砷',
    '銅',
    '錳',
    '銻',
    '電視頻率',
    '電腦',
    '收音機頻率',
    '吹風機',
    '微波爐',
    '行動電話',
    '磁鐵',
    'X光',
    '機動車的油',
    '瓦斯煤氣',
    '樟腦丸',
    '車輛廢氣',
    '烹飪氣體',
    '菸草',
    '化學合成香水',
    '化妝品材料',
    '牙科材料',
    '合成酒精',
    '殺蟲劑',
    '農藥',
    '防腐劑(安息香酸)',
    '色素-紅色',
    '色素-黃色',
    '色素-藍色',
    '美耐皿(三氯氰氨)',
    '住宅灰塵',
    '被褥灰塵',
    '地毯毛皮灰塵',
    '室內裝潢品',
  ];
}