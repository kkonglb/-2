<h1 id="T3373">前端</h1>
使用下列完整的代码替换components下面的VerticalMenu.vue组件

```vue
<template>
    <el-menu :collapse-transition="false" :collapse="flag" style="padding: 5px 20px;max-width: 253px;"
        :default-active="activeIndex" :background-color="bag" text-color="#666" @select="handleSelect">
        <el-menu-item v-for="(item, index) in routes" :key="index" style="width: 100%;"
            v-if="item.show === undefined || item.show !== false" :index="item.path"
            :class="{ 'is-active': activeIndex === item.path }">
            <i :class="item.icon" style="font-size: 20px;"></i>
            <span slot="title" style="font-size: 14px;">{{ item.name }}</span>
        </el-menu-item>
    </el-menu>
</template>
<script>
export default {
    name: 'AdminMenu',
    data() {
        return {
            activeIndex: "1",
            isCollapse: true,
            selectedMenuItem: '',
        }
    },
    props: {
        routes: {
            type: Array,
            required: true
        },
        flag: {
            type: Boolean,
            required: true
        },
        bag: {
            type: String,
            default: '#FFFFFF'
        }
    },
    created() {
        // 上次选中路径
        const saveLastPath = sessionStorage.getItem('activeMenuItem');
        if (saveLastPath === null) {
            // 加载首页
            this.handleSelect('/adminLayout');
        } else {
            this.handleSelect(saveLastPath);
        }
    },
    methods: {
        handleSelect(index) {
            this.activeIndex = index;
            this.$emit('select', this.activeIndex);
            sessionStorage.setItem('activeMenuItem', this.activeIndex);
        },
    },
};
</script>

<style scoped>
.is-active {
    background-color: rgb(241, 241, 241) !important;
    color: #1c1c1c !important;
    font-weight: bold;
    border-radius: 6px;
}

.el-menu-item,
.el-submenu__title {
    height: 45px !important;
    line-height: 45px !important;
    user-select: none;
    color: #333;
}

.el-menu-item:focus,
.el-menu-item:hover {
    box-sizing: border-box;
    border-radius: 5px;
}

.el-menu-item {
    height: 45px !important;
    line-height: 45px !important;
    margin: 3px;
}

.el-menu-item:hover {
    background-color: rgb(241, 241, 241) !important;
}
</style>
```

使用下列完整的代码替换router/index.js路由配置文件

```javascript
import Vue from "vue";
import VueRouter from "vue-router";
import ElementUI from 'element-ui';
import 'element-ui/lib/theme-chalk/index.css';
import { getToken } from "@/utils/storage.js";
import echarts from 'echarts';
Vue.prototype.$echarts = echarts;
Vue.use(ElementUI);
Vue.use(VueRouter);

const routes = [
  { path: "/", component: () => import(`@/views/user/Home.vue`) },
  { path: "/login", component: () => import(`@/views/login/Login.vue`) },
  { path: "/register", component: () => import(`@/views/register/Register.vue`) },
  {
    path: "/admin",
    component: () => import(`@/views/admin/Home.vue`),
    meta: { requireAuth: true },
    children: [
      { path: "/adminLayout", name: '仪表盘', icon: 'el-icon-pie-chart', component: () => import(`@/views/admin/Main.vue`), meta: { requireAuth: true } },
      { path: "/userManage", name: '用户管理', icon: 'el-icon-user-solid', component: () => import(`@/views/admin/User.vue`), meta: { requireAuth: true } },
      { path: "/productManage", name: '商品管理', icon: 'el-icon-shopping-bag-1', component: () => import(`@/views/admin/Product.vue`), meta: { requireAuth: true } },
      { path: "/ordersManage", name: '订单管理', icon: 'el-icon-document-copy', component: () => import(`@/views/admin/Orders.vue`), meta: { requireAuth: true } },
      { path: "/categoryManage", name: '商品类别管理', icon: 'el-icon-document-checked', component: () => import(`@/views/admin/Category.vue`), meta: { requireAuth: true } },
      { path: "/messageManage", name: '消息管理', icon: 'el-icon-chat-square', component: () => import(`@/views/admin/Message.vue`), meta: { requireAuth: true } },
      { path: "/interactionManage", name: '互动管理', icon: 'el-icon-connection', component: () => import(`@/views/admin/Interaction.vue`), meta: { requireAuth: true } },
      { path: "/operationLogManage", name: '日志管理', icon: 'el-icon-connection', component: () => import(`@/views/admin/OperationLog.vue`), meta: { requireAuth: true } },
      { path: "/evaluations", name: '评论管理', icon: 'el-icon-chat-dot-round', component: () => import(`@/views/admin/Evaluations.vue`), meta: { requireAuth: true } },
      { name: '商品详情',show: false, path: "/product-detail1", component: () => import(`@/views/admin/ProductDetail.vue`), meta: { requireAuth: true } },
    ]
  },
  {
    path: "/user",
    component: () => import(`@/views/user/Home.vue`),
    meta: { requireAuth: true },
    children: [
      { name: '商品', path: "/product", component: () => import(`@/views/user/Product.vue`), meta: { requireAuth: true } },
      { name: '我的商品', path: "/myProduct", component: () => import(`@/views/user/MyProduct.vue`), meta: { requireAuth: true } },
      { name: '我的收藏', path: "/mySave", component: () => import(`@/views/user/MySave.vue`), meta: { requireAuth: true } },
      { name: '足迹', path: "/myView", component: () => import(`@/views/user/MyView.vue`), meta: { requireAuth: true } },
      { name: '订单', path: "/orders", component: () => import(`@/views/user/Orders.vue`), meta: { requireAuth: true } },
      { name: '消息', path: "/message", component: () => import(`@/views/user/Message.vue`), meta: { requireAuth: true } },
      { name: '个人中心', path: "/myself", component: () => import(`@/views/user/Myself.vue`), meta: { requireAuth: true } },
      { name: '搜索页', path: "/search", show: false, auth: false, component: () => import(`@/views/user/Search.vue`), meta: { requireAuth: true } },
      { name: '发布商品', path: "/post-product", component: () => import(`@/views/user/PostProduct.vue`), meta: { requireAuth: true } },
      { name: '编辑商品', path: "/edit-product", component: () => import(`@/views/user/EditProduct.vue`), meta: { requireAuth: true } },
      { name: '商品详情', path: "/product-detail", component: () => import(`@/views/user/ProductDetail.vue`), meta: { requireAuth: true } },
    ]
  }
];

const router = new VueRouter({
  routes,
  mode: 'history'
});
router.beforeEach((to, from, next) => {
  if (to.meta.requireAuth) {
    const token = getToken();
    // 需要放行的路由
    const releasePaths = ['/main', '/product'];
    if (releasePaths.includes(to.path)) {
      next();
    } else {
      if (token !== null) {
        next();
      } else {
        next("/login");
      }
    }
  }
  else {
    next();
  }
});
import 'vue-vibe'
export default router;
```

使用下列完整的代码替换admin目录下的Main.vue文件

```vue
<template>
    <div class="dashboard">
        <div class="left">
            <div class="static-count">
                <div v-for="(staticCount, index) in staticCountList" :key="index">
                    <el-statistic group-separator="," :precision="0" :value="staticCount.count"
                        :title="staticCount.name"></el-statistic>
                </div>
            </div>
            <div  style="width: 800px;">
                <LineChart @on-selected="onSelected" tag="商品上架情况" :values="values" :date="dates" height="600px" />
            </div>
        </div>
        <div class="right">
            <h2>最新上架商品</h2>
            <el-col :span="8" v-for="(product, index) in productList" :key="index">
                <div class="item-product">
                    <div class="cover">
                        <img :src="coverListParse(product)" alt="" srcset="">
                    </div>
                    <div style="display: flex;justify-content: left;gap: 4px;align-items: center;">
                        <span class="bargain-hover">{{ product.isBargain ? '支持砍价' : '不支持砍价' }}</span>
                        <span class="title" @click="route(product)">
                            {{ product.name }}
                        </span>
                    </div>
                    <div style="padding-block: 15px;">
                        <span class="decimel-symbol">¥</span>
                        <span class="price">{{ product.price }}</span>
                        <span class="love">{{ product.likeNumber }}人想要</span>
                    </div>
                </div>
            </el-col>
        </div>
    </div>
</template>
<script>
import LineChart from "@/components/LineChart"
export default {
    components: { LineChart },
    data() {
        return {
            staticCountList: [],
            productList: [],
            values: [], // 商品上架的数量趋势情况
            dates: [], // 商品上架的数量趋势情况对应的时间日期
            days: 365, // 数据较少，直接查询一整年的数据
        }
    },
    created() {
        this.fetchStaticCount();
        this.fetchProductList();
        this.onSelected(this.days);
    },
    methods: {
        route(product) {
            // 跳转商品详情
            this.$router.push('/product-detail1?productId=' + product.id);
        },
        /**
        * 商品封面图处理
        * 从字符串转成可用数组
        * @param {*} product 待处理商品信息
        */
        coverListParse(product) {
            if (product.coverList === null) {
                return;
            }
            const newCoverList = product.coverList.split(',');
            return newCoverList[0];
        },
        /**
         * 商品商家情况日期选择回调事件
         * @param {*} day 日期
         */
        onSelected(day) {
            this.$axios.get(`/dashboard/productShelvesInfo/${day}`).then(res => {
                const { data } = res;
                if (data.code === 200) {
                    //[{name: '12-10',count:10},{name: '12-11',count:20}]
                    // [10,20,....]
                    this.values = data.data.map(entity => entity.count);
                    this.dates = data.data.map(entity => entity.name);
                }
            }).catch(error => {
                console.log("商品商家情况异常:", error);
            })
        },
        fetchStaticCount() {
            this.$axios.get('/dashboard/staticCount').then(res => {
                const { data } = res;
                if (data.code === 200) {
                    this.staticCountList = data.data;
                }
            }).catch(error => {
                console.log("基础数据查询异常:", error);
            })
        },
        fetchProductList() {
            const productQueryDto = {
                size: 6,
                current: 1
            }
            this.$axios.post('/product/query', productQueryDto).then(res => {
                const { data } = res;
                if (data.code === 200) {
                    this.productList = data.data;
                }
            }).catch(error => {
                console.log("查询商品信息异常:", error);
            })
        },
    },
};
</script>
<style scoped lang="scss">
.dashboard {
    display: flex;
    justify-content: left;
    gap: 10px;

    .left {
        padding-block: 22px;
        padding-inline: 30px;
        //background-color: rgb(249, 249, 249);

        .static-count {
            display: flex;
            justify-content: space-evenly;
            gap: 80px;
            margin-bottom: 40px;
        }
    }

    .right {
        box-sizing: border-box;
        width: 500px;

        .item-product {
            padding: 10px 10px 16px 10px;
            box-sizing: border-box;
            border-radius: 15px;
            transition: all .5s;
            cursor: pointer;

            .cover {
                img {
                    width: 100%;
                    height: 120px;
                    border-radius: 10px;
                }
            }

            .bargain-hover {
                font-size: 12px;
                font-weight: 800;
                background-color: rgb(255, 230, 15);
                color: rgb(51, 51, 51);
                border-radius: 2px;
                padding: 2px 6px;
            }

            .title {
                font-size: 20px;
                color: #1f1f1f;
            }

            .decimel-symbol {
                font-size: 14px;
                color: #ff4f24;
                font-weight: 800;
            }

            .price {
                font-size: 24px;
                color: #ff4f24;
                font-weight: 800;
                margin-right: 6px;
            }

            .love {
                font-size: 14px;
                color: #999;
            }

        }

        .item-product:hover {
            box-shadow: 1px 4px 6px rgba(0, 0, 0, 0.1), 0 1px 3px rgba(0, 0, 0, 0.06);
        }

    }
}
</style>
```

使用下列完整的代码替换user目录下的MyProduct.vue文件

```vue
<template>
    <div class="product-list">
        <el-row v-if="productList.length === 0">
            <el-empty description="暂无商品信息"></el-empty>
        </el-row>
        <el-row v-else>
            <el-col :span="6" v-for="(product, index) in productList" :key="index">
                <div class="item-product">
                    <div class="cover">
                        <img :src="coverListParse(product)" alt="" srcset="">
                    </div>
                    <div style="display: flex;justify-content: left;gap: 4px;align-items: center;">
                        <span class="bargain-hover">{{ product.isBargain ? '支持砍价' : '不支持砍价' }}</span>
                        <span class="title" @click="route(product)">
                            {{ product.name }}
                        </span>
                    </div>
                    <div style="padding-block: 15px;">
                        <span class="decimel-symbol">¥</span>
                        <span class="price">{{ product.price }}</span>
                        <span class="love">{{ product.likeNumber }}人想要</span>
                    </div>
                    <div>
                        <span @click="handleEdit(product)" class="edit-button">编辑</span>
                        <span @click="handleDelete(product)" class="channel-button">删除</span>
                    </div>
                </div>
            </el-col>
        </el-row>
    </div>
</template>
<script>
import { setProductInfo } from "@/utils/storage"
export default {
    name: 'MyProduct',
    data() {
        return {
            productList: []
        };
    },
    created() {
        this.fetchProduct();
    },
    methods: {
        route(product) {
            // 跳转商品详情
            this.$router.push('/product-detail?productId=' + product.id);
        },
        /**
         * 商品编辑
         * @param {*} product 待处理的商品信息
         */
        handleEdit(product) {
            // 先将待操作商品信息存起来
            setProductInfo(product);
            this.$router.push('/edit-product');
        },
        /**
         * 商品删除
         * @param {*} product 待操作商品信息
         */
        async handleDelete(product) {
            const confirmed = await this.$swalConfirm({
                title: `删除【${product.name}】商品`,
                text: `删除后不可恢复，是否继续？`,
                icon: 'warning',
            });
            if (confirmed) {
                try {
                    let ids = [product.id]
                    const response = await this.$axios.post(`/product/batchDelete`, ids);
                    if (response.data.code === 200) {
                        this.$notify({
                            duration: 1000,
                            title: '信息删除',
                            message: '删除成功',
                            type: 'success'
                        });
                        this.fetchProduct();
                        return;
                    }
                } catch (error) {
                    this.$notify({
                        duration: 2000,
                        title: '信息删除',
                        message: error,
                        type: 'error'
                    });
                    console.error(`商品信息删除异常：`, error);
                }
            }

        },
        /**
         * 商品封面图处理
         * 从字符串转成可用数组
         * @param {*} product 待处理商品信息
         */
        coverListParse(product) {
            if (product.coverList === null) {
                return;
            }
            const newCoverList = product.coverList.split(',');
            return newCoverList[0];
        },
        /**
         * 查询用户自己发布的商品信息
         */
        fetchProduct() {
            this.$axios.post('/product/queryUser', {}).then(res => {
                const { data } = res; // 解构
                if (data.code === 200) {
                    this.productList = data.data;
                }
            }).catch(error => {
                console.log("商品查询异常：", error);
            })
        },
    }
};
</script>
<style scoped lang="scss">
.product-list {
    padding-block: 20px;

    .item-product {
        padding: 10px 10px 16px 10px;
        box-sizing: border-box;
        border-radius: 15px;
        transition: all .5s;
        cursor: pointer;

        .cover {
            img {
                width: 100%;
                height: 240px;
                border-radius: 10px;
            }
        }

        .bargain-hover {
            font-size: 12px;
            font-weight: 800;
            background-color: rgb(255, 230, 15);
            color: rgb(51, 51, 51);
            border-radius: 2px;
            padding: 2px 6px;
        }

        .title {
            font-size: 20px;
            color: #1f1f1f;
        }

        .decimel-symbol {
            font-size: 14px;
            color: #ff4f24;
            font-weight: 800;
        }

        .price {
            font-size: 24px;
            color: #ff4f24;
            font-weight: 800;
            margin-right: 6px;
        }

        .love {
            font-size: 14px;
            color: #999;
        }

    }

    .item-product:hover {
        box-shadow: 1px 4px 6px rgba(0, 0, 0, 0.1), 0 1px 3px rgba(0, 0, 0, 0.06);
    }
}
</style>
```

使用下列完整的代码替换user目录下的MySave.vue文件

```vue
<template>
    <div class="product-list">
        <el-row v-if="productList.length === 0">
            <el-empty description="暂无商品信息"></el-empty>
        </el-row>
        <el-row v-else>
            <el-col :span="6" v-for="(product, index) in productList" :key="index">
                <div class="item-product">
                    <div class="cover">
                        <img :src="coverListParse(product)" alt="" srcset="">
                    </div>
                    <div style="display: flex;justify-content: left;gap: 4px;align-items: center;">
                        <span class="bargain-hover">{{ product.isBargain ? '支持砍价' : '不支持砍价' }}</span>
                        <span class="title" @click="route(product)">
                            {{ product.name }}
                        </span>
                    </div>
                    <div style="padding-block: 15px;">
                        <span class="decimel-symbol">¥</span>
                        <span class="price">{{ product.price }}</span>
                    </div>
                </div>
            </el-col>
        </el-row>
    </div>
</template>
<script>
import { setProductInfo } from "@/utils/storage"
export default {
    name: 'MyProduct',
    data() {
        return {
            productList: []
        };
    },
    created() {
        this.fetchProduct();
    },
    methods: {
        route(product) {
            // 跳转商品详情
            this.$router.push('/product-detail?productId=' + product.id);
        },
        /**
         * 商品封面图处理
         * 从字符串转成可用数组
         * @param {*} product 待处理商品信息
         */
        coverListParse(product) {
            if (product.coverList === null) {
                return;
            }
            const newCoverList = product.coverList.split(',');
            return newCoverList[0];
        },
        /**
         * 查询用户自己发布的商品信息
         */
        fetchProduct() {
            this.$axios.post('/interaction/queryUser').then(res => {
                const { data } = res; // 解构
                if (data.code === 200) {
                    this.productList = data.data;
                }
            }).catch(error => {
                console.log("商品查询异常：", error);
            })
        },
    }
};
</script>
<style scoped lang="scss">
.product-list {
    padding-block: 20px;

    .item-product {
        padding: 10px 10px 16px 10px;
        box-sizing: border-box;
        border-radius: 15px;
        transition: all .5s;
        cursor: pointer;

        .cover {
            img {
                width: 100%;
                height: 240px;
                border-radius: 10px;
            }
        }

        .bargain-hover {
            font-size: 12px;
            font-weight: 800;
            background-color: rgb(255, 230, 15);
            color: rgb(51, 51, 51);
            border-radius: 2px;
            padding: 2px 6px;
        }

        .title {
            font-size: 20px;
            color: #1f1f1f;
        }

        .decimel-symbol {
            font-size: 14px;
            color: #ff4f24;
            font-weight: 800;
        }

        .price {
            font-size: 24px;
            color: #ff4f24;
            font-weight: 800;
            margin-right: 6px;
        }

        .love {
            font-size: 14px;
            color: #999;
        }

    }

    .item-product:hover {
        box-shadow: 1px 4px 6px rgba(0, 0, 0, 0.1), 0 1px 3px rgba(0, 0, 0, 0.06);
    }
}
</style>
```

使用下列完整的代码替换user目录下的MyView.vue文件

```vue
<template>
    <div class="product-list">
        <div class="clear-message">
            <span @click="clearView">
                <i class="el-icon-s-open"></i>
            </span>
        </div>
        <el-row v-if="productList.length === 0">
            <el-empty description="浏览记录为空"></el-empty>
        </el-row>
        <el-row v-else>
            <el-col :span="6" v-for="(product, index) in productList" :key="index">
                <div class="item-product">
                    <div class="cover">
                        <img :src="coverListParse(product)" alt="" srcset="">
                    </div>
                    <div style="display: flex;justify-content: left;gap: 4px;align-items: center;">
                        <span class="bargain-hover">{{ product.isBargain ? '支持砍价' : '不支持砍价' }}</span>
                        <span class="title" @click="route(product)">
                            {{ product.name }}
                        </span>
                    </div>
                    <div style="padding-block: 15px;">
                        <span class="decimel-symbol">¥</span>
                        <span class="price">{{ product.price }}</span>
                    </div>
                </div>
            </el-col>
        </el-row>
    </div>
</template>
<script>
export default {
    name: 'MyProduct',
    data() {
        return {
            productList: []
        };
    },
    created() {
        this.fetchProduct();
    },
    methods: {
        clearView() {
            this.$axios.post(`/interaction/batchDeleteView`).then(res => {
                const { data } = res; // 解构
                if (data.code === 200) {
                    this.$notify({
                        duration: 1000,
                        title: '足迹清除成功',
                        message: data.msg,
                        type: 'success'
                    });
                    this.fetchProduct();
                }
            }).catch(error => {
                console.log("商品足迹清除异常：", error);
            })
        },
        route(product) {
            // 跳转商品详情
            this.$router.push('/product-detail?productId=' + product.id);
        },
        /**
         * 商品封面图处理
         * 从字符串转成可用数组
         * @param {*} product 待处理商品信息
         */
        coverListParse(product) {
            if (product.coverList === null) {
                return;
            }
            const newCoverList = product.coverList.split(',');
            return newCoverList[0];
        },
        /**
         * 查询用户自己发布的商品信息
         */
        fetchProduct() {
            this.$axios.post('/interaction/myView').then(res => {
                const { data } = res; // 解构
                if (data.code === 200) {
                    this.productList = data.data;
                }
            }).catch(error => {
                console.log("商品查询异常：", error);
            })
        },
    }
};
</script>
<style scoped lang="scss">
.product-list {
    padding-block: 20px;

    .clear-message {
        margin-block: 10px;
        display: flex;
        justify-content: right;

        span:hover {
            background-color: rgb(241, 241, 241);
        }

        span {
            display: flex;
            justify-content: center;
            align-items: center;
            cursor: pointer;
            width: 30px;
            height: 30px;
            border-radius: 50%;
            background-color: rgb(246, 246, 246);
        }
    }

    .item-product {
        padding: 10px 10px 16px 10px;
        box-sizing: border-box;
        border-radius: 15px;
        transition: all .5s;
        cursor: pointer;

        .cover {
            img {
                width: 100%;
                height: 240px;
                border-radius: 10px;
            }
        }

        .bargain-hover {
            font-size: 12px;
            font-weight: 800;
            background-color: rgb(255, 230, 15);
            color: rgb(51, 51, 51);
            border-radius: 2px;
            padding: 2px 6px;
        }

        .title {
            font-size: 20px;
            color: #1f1f1f;
        }

        .decimel-symbol {
            font-size: 14px;
            color: #ff4f24;
            font-weight: 800;
        }

        .price {
            font-size: 24px;
            color: #ff4f24;
            font-weight: 800;
            margin-right: 6px;
        }

        .love {
            font-size: 14px;
            color: #999;
        }

    }

    .item-product:hover {
        box-shadow: 1px 4px 6px rgba(0, 0, 0, 0.1), 0 1px 3px rgba(0, 0, 0, 0.06);
    }
}
</style>
```

使用下列完整的代码替换admin目录下的Product.vue文件

```vue
<template>
    <div>
        <div class="nav-category">
            <div class="left">
                <span :style="{
                    color: categorySelectedItem.name === isUseCategory.name ? 'rgb(51, 51, 51)' : '',
                    backgroundColor: categorySelectedItem.name === isUseCategory.name ? 'rgb(254, 223, 70)' : ''
                }" @click="categorySelected(isUseCategory)" :key="index"
                    v-for="(isUseCategory, index) in isUseCategoryList">
                    {{ isUseCategory.name }}
                </span>
            </div>
            <div class="right">
                <span class="bargain">
                    <span :style="{
                        color: bargainSelectedItem.name === bargain.name ? 'rgb(51,51,51)' : '',
                        backgroundColor: bargainSelectedItem.name === bargain.name ? 'rgb(254, 223, 70)' : ''
                    }" @click="bargainSelected(bargain)" v-for="(bargain, index) in bargainStatus" :key="index">{{
                        bargain.name }}</span>
                </span>
                <el-date-picker style="width: 216px;margin-right: 5px;" @change="fetchFreshData" size="small"
                    v-model="searchTime" type="daterange" range-separator="至" start-placeholder="发布开始"
                    end-placeholder="发布结束">
                </el-date-picker>
                <el-select style="width: 100px;margin-right: 5px;" @change="fetchFreshData" size="small"
                    v-model="productQueryDto.categoryId" placeholder="商品类别">
                    <el-option v-for="item in categoryList" :key="item.id" :label="item.name" :value="item.id">
                    </el-option>
                </el-select>
            </div>
        </div>
        <div class="product-list">
            <el-row v-if="productList.length === 0">
                <el-empty description="暂无商品信息"></el-empty>
            </el-row>
            <el-row v-else>
                <el-col @click.native="route(product)" :span="6" v-for="(product, index) in productList" :key="index">
                    <div class="item-product">
                        <div class="cover">
                            <img :src="coverListParse(product)" alt="" srcset="">
                        </div>
                        <div style="display: flex;justify-content: left;gap: 4px;align-items: center;">
                            <span class="bargain-hover">{{ product.isBargain ? '支持砍价' : '不支持砍价' }}</span>
                            <span class="title">
                                {{ product.name }}
                            </span>
                        </div>
                        <div style="padding-block: 15px;">
                            <span class="decimel-symbol">¥</span>
                            <span class="price">{{ product.price }}</span>
                            <span class="love">{{ product.likeNumber }}人想要</span>
                        </div>
                        <div class="info">
                            <img :src="product.userAvatar" alt="" srcset="">
                            <span>{{ product.userName }}</span>
                        </div>
                    </div>
                </el-col>
            </el-row>
        </div>
    </div>
</template>
<script>
export default {
    name: 'Product',
    data() {
        return {
            categoryList: [], // 存储的商品类别数组
            isUseCategoryList: [], // 存储的启用的类别数组
            categorySelectedItem: {},
            productQueryDto: {}, // 商品查询条件类
            productList: [],// 存储后端返回的商品数据列表
            bargainSelectedItem: {},
            searchTime: [],
            bargainStatus: [{ isBargain: null, name: '全部' }, { isBargain: true, name: '支持砍价' }, { isBargain: false, name: '不支持砍价' }]

        };
    },
    created() {
        this.fetchFreshData();
        this.fetchCategoryList();
        // 页面加载时，默认不启用砍价查询条件
        this.bargainSelected(this.bargainStatus[0]);
    },
    methods: {
        route(product) {
            // 跳转商品详情
            this.$router.push('/product-detail?productId=' + product.id);
        },
        coverListParse(product) {
            if (product.coverList === null) {
                return;
            }
            const newCoverList = product.coverList.split(',');
            return newCoverList[0];
        },
        /**
         * 商品砍价选中事件
         * @param {*} bargain 
         */
        bargainSelected(bargain) {
            this.bargainSelectedItem = bargain;
            this.productQueryDto.isBargain = bargain.isBargain;
            this.fetchFreshData();
        },
        /**
         * 查询商品数据
         */
        async fetchFreshData() {
            let startTime = null;
            let endTime = null;
            if (this.searchTime != null && this.searchTime.length === 2) {
                const [startDate, endDate] = await Promise.all(this.searchTime.map(date => date.toISOString()));
                startTime = `${startDate.split('T')[0]}T00:00:00`;
                endTime = `${endDate.split('T')[0]}T23:59:59`;
            }
            // this.productQueryDto.current = this.currentPage;
            // this.productQueryDto.size = this.pageSize;
            this.productQueryDto.startTime = startTime;
            this.productQueryDto.endTime = endTime;
            this.$axios.post('/product/query', this.productQueryDto).then(res => {
                const { data } = res; // 解构
                if (data.code === 200) {
                    this.productList = data.data;
                }
            }).catch(error => {
                console.log("商品查询异常：", error);
            })
        },
        /**
         * 商品类别选中事件
         * @param {*} category 
         */
        categorySelected(category) {
            this.categorySelectedItem = category;
            this.productQueryDto.categoryId = category.id;
            // 查询对应的商品分类下面的商品数据
            this.fetchFreshData();
        },
        /**
         * 加载商品类别数据
         */
        fetchCategoryList() {
            this.$axios.post('/category/query', {}).then(res => {
                const { data } = res; // 解构
                if (data.code === 200) {
                    this.categoryList = data.data;
                    this.isUseCategoryList = data.data.filter(category => category.isUse);
                    this.isUseCategoryList.unshift({ id: null, name: '全部' });
                    this.categorySelected(this.isUseCategoryList[0]);
                }
            }).catch(error => {
                console.log("商品类别查询异常：", error);
            })
        },
    }
};
</script>
<style scoped lang="scss">
.cover {
    img {
        width: 100%;
        height: 240px;
        border-radius: 10px;
    }
}

.bargain-hover {
    font-size: 12px;
    font-weight: 800;
    background-color: rgb(255, 230, 15);
    color: rgb(51, 51, 51);
    border-radius: 2px;
    padding: 2px 6px;
}

.title {
    font-size: 20px;
    color: #1f1f1f;
}

.decimel-symbol {
    font-size: 14px;
    color: #ff4f24;
    font-weight: 800;
}

.price {
    font-size: 24px;
    color: #ff4f24;
    font-weight: 800;
    margin-right: 6px;
}

.love {
    font-size: 14px;
    color: #999;
}

.info {
    display: flex;
    justify-content: left;
    align-items: center;
    gap: 4px;

    img {
        width: 20px;
        height: 20px;
        border-radius: 50%;
    }

    span {
        font-size: 14px;
        color: #999;
    }
}

.bargain {
    display: inline-block;
    font-size: 12px;
    background-color: rgb(246, 246, 246);
    line-height: 24px;
    padding-inline: 10px;
    padding-block: 4px;
    margin-right: 5px;
    border-radius: 5px;
    cursor: pointer;

    span {
        display: inline-block;
        padding-inline: 10px;
        border-radius: 5px;
    }
}

.product-list {
    padding-block: 20px;

    .item-product {
        padding: 10px 10px 16px 10px;
        box-sizing: border-box;
        border-radius: 15px;
        transition: all .5s;
        cursor: pointer;
    }

    .item-product:hover {
        box-shadow: 1px 4px 6px rgba(0, 0, 0, 0.1), 0 1px 3px rgba(0, 0, 0, 0.06);
    }
}

.nav-category {
    display: flex;
    justify-content: space-between;

    .left {
        display: flex;
        justify-content: left;
        gap: 6px;

        span {
            display: inline-block;
            background-color: rgb(246, 246, 246);
            padding: 6px 22px;
            cursor: pointer;
            border-radius: 15px;
        }

        span:hover {
            background-color: rgb(242, 242, 242);
        }
    }
}
</style>
```

使用下列完整的代码替换user目录下面的ProductDetail.vue文件

```vue
<template>
    <div class="detail-container">
        <div class="cover">
            <div>
                <div :style="{
                    border: coverIndex === index ? '1px solid rgb(51,51,51)' : ''
                }" @click="coverSelected(coverItem, index)" class="cover-item" v-for="(coverItem, index) in coverList"
                    :key="index">
                    <img :src="coverItem" alt="" srcset="">
                </div>
            </div>
            <div class="large-cover">
                <div>
                    <i @click="coverToLeft" class="el-icon-arrow-left"></i>
                </div>
                <img :src="coverItem" alt="" srcset="">
                <div>
                    <i @click="coverToRight" class="el-icon-arrow-right"></i>
                </div>
            </div>
        </div>
        <div class="info">
            <div class="decimal">
                <span class="price"><span class="symbol">￥</span>{{ product.price }}</span>
                <span style="border: 2px solid rgb(214, 214, 214);border-radius: 50%;"></span>
                <span>{{ product.categoryName }}</span>
                <span style="border: 2px solid rgb(214, 214, 214);border-radius: 50%;"></span>
                <img :src="product.userAvatar" style="width: 20px;height: 20px;border-radius: 50%;" alt="" srcset="">
                <span>{{ product.userName }}</span>
                <span class="bargain">{{ product.isBargain ? '可砍价' : '不支持砍价' }}</span>
            </div>
            <div class="decimal">
                <span class="love">{{ product.likeNumber }}人想要</span>
                <span style="border: 2px solid rgb(214, 214, 214);border-radius: 50%;"></span>
                <span class="love">{{ product.saveNumber }}人收藏</span>
                <span style="border: 2px solid rgb(214, 214, 214);border-radius: 50%;"></span>
                <span class="love">{{ product.viewNumber }}人浏览</span>
                <span style="border: 2px solid rgb(214, 214, 214);border-radius: 50%;"></span>
                <span>{{ product.oldLevel }}成新</span>
                <span style="border: 2px solid rgb(214, 214, 214);border-radius: 50%;"></span>
                <span>库存&nbsp;{{ product.inventory }}（件/盒/箱..）</span>
            </div>
            <div class="name">
                {{ product.name }}
            </div>
            <div>
                <div v-html="product.detail"></div>
            </div>
            <div class="operation">
                <div class="left">
                    <span @click="likeProduct"><i class="el-icon-sell" style="margin-right: 5px;"></i>我想要</span>
                    <span @click="buyProduct">立即购买</span>
                </div>
                <div class="right">
                    <span @click="saveOperation"><i style="margin-right: 5px;" class="el-icon-star-off"></i>{{ saveFlag
                        ? '取消收藏' : '收藏' }}</span>
                </div>
            </div>
            <div v-if="userInfo !== null">
                <Evaluations contentType="PRODUCT" :contentId="product.id" />
            </div>
        </div>
        <el-dialog :show-close="false" :visible.sync="dialogProductOperaion" width="35%">
            <div style="padding:16px 20px;">
                <p>商品下单</p>
                <div class="info">
                    <div class="decimal">
                        <span class="price"><span class="symbol">￥</span>{{ product.price }}</span>
                        <span style="border: 2px solid rgb(214, 214, 214);border-radius: 50%;"></span>
                        <span>{{ product.categoryName }}</span>
                        <span style="border: 2px solid rgb(214, 214, 214);border-radius: 50%;"></span>
                        <img :src="product.userAvatar" style="width: 20px;height: 20px;border-radius: 50%;" alt=""
                            srcset="">
                        <span>{{ product.userName }}</span>
                        <span class="bargain">{{ product.isBargain ? '可砍价' : '不支持砍价' }}</span>
                    </div>
                    <div class="decimal">
                        <span style="border: 2px solid rgb(214, 214, 214);border-radius: 50%;"></span>
                        <span>{{ product.oldLevel }}成新</span>
                        <span style="border: 2px solid rgb(214, 214, 214);border-radius: 50%;"></span>
                        <span>库存&nbsp;{{ product.inventory }}（件/盒/箱..）</span>
                    </div>
                    <div class="name">
                        {{ product.name }}
                    </div>
                </div>
                <div>
                    <p>下单数量</p>
                    <el-input-number v-model="buyNumber" :min="1" :max="product.inventory"
                        label="请选择"></el-input-number>
                </div>
                <div>
                    <p>备注信息</p>
                    <el-input type="textarea" :rows="3" placeholder="补充备注" v-model="detail">
                    </el-input>
                </div>
            </div>
            <span slot="footer" class="dialog-footer" style="margin-top: 10px;">
                <span class="channel-button" @click="cannelBuy()">
                    取消下单
                </span>
                <span class="edit-button" @click="buyConfirm()">
                    确定下单
                </span>
            </span>
        </el-dialog>
    </div>
</template>
<script>
import { getUserInfo } from "@/utils/storage"
import Evaluations from "@/components/Evaluations"
export default {
    components: { Evaluations },
    name: 'ProductDetail',
    data() {
        return {
            productId: null,
            product: {},
            coverList: [],
            coverIndex: 0,
            coverItem: null,
            keyInterval: null,
            saveFlag: false, // 判断用户是否已经收藏
            dialogProductOperaion: false,
            buyNumber: 1,
            detail: '',
            userInfo: null
        }
    },
    created() {
        this.getParam();
        this.viewOperation();
    },
    beforeDestroy() {
        this.clearBanner(); // 清除定时器
    },
    methods: {
        // 浏览操作
        viewOperation() {
            const userInfo = getUserInfo();
            if (userInfo === null) { // 没登录不用记录
                return;
            }
            this.userInfo = userInfo;
            // 对于用户这是无感的
            this.$axios.post(`/interaction/view/${this.productId}`).then(res => {
                const { data } = res; // 解构
                if (data.code === 200) {
                    console.log("用户浏览已经处理");
                }
            }).catch(error => {
                console.log("浏览记录异常：", error);
            })
        },
        /**
         * 商品下单
         */
        buyConfirm() {
            const ordersDTO = {
                productId: this.product.id,
                buyNumber: this.buyNumber,
                detail: this.detail
            }
            this.$axios.post(`/product/buyProduct`, ordersDTO).then(res => {
                const { data } = res; // 解构
                if (data.code === 200) {
                    this.$notify({
                        duration: 1000,
                        title: '下单操作',
                        message: data.msg,
                        type: 'success'
                    });
                    this.fetchProduct(this.product.id);
                    this.cannelBuy();
                } else {
                    this.$notify({
                        duration: 2000,
                        title: '下单操作',
                        message: data.msg,
                        type: 'error'
                    });
                }
            }).catch(error => {
                this.$notify({
                    duration: 2000,
                    title: '下单操作',
                    message: error,
                    type: 'error'
                });
                console.log("商品下单异常：", error);
            })
        },
        cannelBuy() {
            this.dialogProductOperaion = false;
            this.buyNumber = 1;
        },
        buyProduct() {
            const userInfo = getUserInfo();
            if (userInfo === null) { // 没登录不用记录
                this.$notify({
                    duration: 1000,
                    title: '未登录',
                    message: '登录后才可操作',
                    type: 'info'
                });
                this.$router.push('/login');
                return;
            }
            this.dialogProductOperaion = true;
        },
        likeProduct() {
            this.$axios.post(`/interaction/likeProduct/${this.product.id}`).then(res => {
                const { data } = res; // 解构
                if (data.code === 200) {
                    this.$notify({
                        duration: 1000,
                        title: '想要操作通知',
                        message: data.msg,
                        type: 'success'
                    });
                } else {
                    this.$notify({
                        duration: 2000,
                        title: '想要操作通知',
                        message: data.msg,
                        type: 'info'
                    });
                    this.$router.push('/login');
                }
            }).catch(error => {
                console.log("商品---想要---异常：", error);
            })
        },
        querySaveStatus() {
            // 判断用户是否已经登录
            const userInfo = getUserInfo();
            if (userInfo === null) { // 没登录不用查
                console.log("用户未登录");
                return;
            }
            const interactionQueryDto = {
                userId: userInfo.id,
                productId: this.product.id,
                type: 1 // 1代表的是收藏行为
            };
            this.$axios.post('/interaction/query', interactionQueryDto).then(res => {
                const { data } = res; // 解构
                if (data.code === 200) {
                    // 代表没有收藏
                    this.saveFlag = data.total !== 0;
                }
            }).catch(error => {
                console.log("商品查询异常：", error);
            })
        },
        /**
         * 收藏操作 （收藏跟取消收藏是一组对立的操作）
         */
        saveOperation() {
            const userInfo = getUserInfo();
            if (userInfo === null) { // 没登录不用记录
                this.$notify({
                    duration: 1000,
                    title: '未登录',
                    message: '登录后才可操作',
                    type: 'info'
                });
                this.$router.push('/login');
                return;
            }
            this.$axios.post(`/interaction/saveOperation/${this.product.id}`).then(res => {
                const { data } = res; // 解构
                if (data.code === 200) {
                    // 代表没有收藏
                    this.saveFlag = data.data;
                    this.$notify({
                        duration: 1000,
                        title: '收藏操作成功',
                        message: data.msg,
                        type: 'success'
                    });
                }
            }).catch(error => {
                console.log("商品查询异常：", error);
            })
        },
        clearBanner() {
            if (this.keyInterval) {
                clearInterval(this.keyInterval);
                this.keyInterval = null; // 重置定时器引用
            }
        },
        startBanner() {
            this.keyInterval = setInterval(() => {
                if (this.coverIndex === this.coverList.length - 1) {
                    this.coverIndex = 0;
                } else {
                    this.coverIndex = this.coverIndex + 1;
                }
                this.coverItem = this.coverList[this.coverIndex];
            }, 5000);
        },
        coverToLeft() {
            if (this.coverIndex === 0) {
                this.coverIndex = this.coverList.length - 1;
            } else {
                this.coverIndex = this.coverIndex - 1;
            }
            this.coverItem = this.coverList[this.coverIndex];
        },
        coverToRight() {
            if (this.coverIndex === this.coverList.length - 1) {
                this.coverIndex = 0;
            } else {
                this.coverIndex = this.coverIndex + 1;
            }
            this.coverItem = this.coverList[this.coverIndex];
        },
        coverSelected(coverItem, index) {
            this.coverItem = coverItem;
            this.coverIndex = index;
        },
        /**
         * 从路径上取得商品ID
         */
        getParam() {
            const param = this.$route.query;
            this.productId = Number(param.productId);
            this.fetchProduct(this.productId);
        },
        coverListParse(product) {
            if (product.coverList === null) {
                return;
            }
            this.coverList = product.coverList.split(',');
            // 默认选中第一张封面
            this.coverItem = this.coverList[0];
            // 启动定时器，定时轮播
            this.startBanner();
        },
        fetchProduct(productId) {
            this.$axios.post('/product/query', { id: productId }).then(res => {
                const { data } = res; // 解构
                if (data.code === 200) {
                    this.product = data.data[0];
                    this.coverListParse(this.product);
                    this.querySaveStatus();
                }
            }).catch(error => {
                console.log("商品查询异常：", error);
            })
        },
    }
};
</script>
<style scoped lang="scss">
.love {
    font-size: 14px;
    color: #999;
}

.info {
    width: 500px;

    .operation {
        display: flex;
        justify-content: left;
        gap: 20px;
        font-size: 14px;
        cursor: pointer;

        .right {
            span:hover {
                background-color: rgb(241, 241, 241);
            }

            span {
                display: inline-block;
                width: 100px;
                text-align: center;
                background-color: rgb(246, 246, 246);
                border-radius: 20px;

            }
        }

        .left {
            display: flex;
            justify-content: space-evenly;

            span {
                display: inline-block;
                width: 160px;
                text-align: center;
            }

            span:first-child {
                background-color: rgb(255, 230, 15);
                border-top-left-radius: 20px;
                border-bottom-left-radius: 20px;
            }

            span:last-child {
                background-color: rgb(59, 59, 59);
                color: rgb(245, 245, 245);
                border-top-right-radius: 20px;
                border-bottom-right-radius: 20px;
            }
        }

        div {
            line-height: 40px;
        }
    }

    .name {
        margin-block: 10px;
        font-size: 24px;
    }

    .decimal {
        display: flex;
        justify-content: left;
        align-items: center;
        gap: 10px;
        font-size: 14px;
        margin-block: 6px;
        width: 500px;

        .price {
            .symbol {
                font-size: 16px;
            }

            font-size: 32px;
            font-weight: 800;
            color: rgb(255, 68, 0);
        }

        .bargain {
            font-size: 10px;
            color: rgb(51, 51, 51);
            background-color: rgb(246, 228, 24);
            padding: 2px 4px;
            border-radius: 5px;
        }
    }

}

.detail-container {
    display: flex;
    justify-content: left;

    .cover {
        display: flex;
        justify-content: left;

        .large-cover {
            padding: 6px;
            margin: 10px;
            display: flex;
            justify-content: left;
            gap: 10px;

            i:hover {
                background-color: rgb(246, 246, 246);
            }

            i {
                display: inline-block;
                padding: 20px;
                border-radius: 50%;
                font-size: 20px;
                font-weight: 800;
                cursor: pointer;
            }

            img {
                width: 280px;
                height: 280px;
            }
        }

        .cover-item:hover {
            border: 1px solid rgb(51, 51, 51);
        }

        .cover-item {
            padding: 6px;
            margin: 10px;
            border: 1px solid rgb(255, 255, 255);
            border-radius: 5px;
            transition: all .5s;

            img {
                width: 80px;
                height: 80px;
            }
        }
    }
}
</style>
```

替换user下面的Home.vue文件

```vue
<template>
    <div>
        <div class="container">
            <div class="top">
                <div class="nav">
                    <div>
                        <Logo name="校园交易" />
                    </div>
                    <div class="route">
                        <span @click="handleRouteSelect('/product')">商品</span>
                        <span v-if="loginStatus" @click="handleRouteSelect('/myProduct')">我的商品</span>
                        <span v-if="loginStatus" @click="handleRouteSelect('/mySave')">我的收藏</span>
                        <span v-if="loginStatus" @click="handleRouteSelect('/myView')">足迹</span>
                    </div>
                </div>
                <div
                    style="cursor: pointer;font-size: 14px;display: flex;justify-content: left;align-items: center;gap: 20px;color: rgb(143, 143, 143);">
                    <div class="word-search">
                        <div class="item">
                            <input type="text" placeholder="搜索商品" v-model="key">
                            <i class="el-icon-search" @click="fetch"></i>
                        </div>
                    </div>
                    <div style="text-align: center;" v-if="loginStatus" @click="handleRouteSelect('/orders')">
                        <div>
                            <i class="el-icon-document"></i>
                        </div>
                        <div>
                            订单
                        </div>
                    </div>
                    <div style="text-align: center;" v-if="loginStatus" @click="handleRouteSelect('/message')">
                        <div>
                            <i class="el-icon-bell"></i>
                        </div>
                        <div>
                            通知
                        </div>
                    </div>
                    <div style="text-align: center;" v-if="loginStatus" @click="handleRouteSelect('/post-product')">
                        <div>
                            <i class="el-icon-plus"></i>
                        </div>
                        <div>
                            发布商品
                        </div>
                    </div>
                    <div v-if="!loginStatus" @click="loginOperation">
                        登录&nbsp;|&nbsp;注册
                    </div>
                    <div v-else>
                        <img @click="handleRouteSelect('/myself')" class="avatar" :src="userInfo.userAvatar">
                    </div>
                </div>
            </div>
            <div class="info" v-if="loginStatus">
                <div>
                    <img :src="userInfo.userAvatar" style="width: 90px;width: 90px;border-radius: 50%;">
                </div>
                <div style="padding: 0 40px;">
                    <div class="title1">
                        <span class="title">{{ userInfo.userName }}</span>
                        <span  class="poin" v-for="(info,index) in productInfoList" :key="index">
                            {{info.name}}·{{ info.count }}
                        </span>
                    </div>
                    <div class="date">
                        上一次登录时间： {{ userInfo.lastLoginTime }}
                    </div>
                    <div class="date">
                        注册于： {{ userInfo.createTime }}
                    </div>
                </div>
            </div>
        </div>
        <div style="padding: 10px 300px;">
            <router-view></router-view>
        </div>
    </div>
</template>
<script>
import Logo from "@/components/Logo";
import { getToken, setUserInfo, setSearchKey } from "@/utils/storage";
export default {
    name: "Home",
    components: {
        Logo,
    },
    data() {
        return {
            selfPath: { name: '个人中心', path: '/mySelf' },
            userRoutes: [],
            key: null,
            dialogOperaion: false,
            loginStatus: false, // 默认未登录
            userInfo: {},
            searchPath: '/search',
            productInfoList: []
        };
    },
    created() {
        this.loadLoginStatus();
        this.handleRouteSelect('/product')
    },
    methods: {
        queryProductInfo() {
            this.$axios.post(`/product/queryProductInfo`, {}).then(res => {
                const { data } = res;
                if (data.code === 200) {
                    this.productInfoList = data.data;
                }
                this.loginStatus = data.code === 200;
            }).catch(error => {
                console.log("商品指标查询异常：", error);
            });
        },
        // 跳转登录页
        loginOperation() {
            this.$router.push('/login');
        },
        // 搜索
        fetch() {
            setSearchKey(this.key);
            this.handleRouteSelect(this.searchPath);
        },
        // 路由切换
        handleRouteSelect(path) {
            if (this.$router.currentRoute.fullPath !== path) {
                this.$router.push(path);
            }
        },
        //判断用户是否已经登录
        loadLoginStatus() {
            const token = getToken();
            // 没登录
            if (token === null) {
                this.loginStatus = false;
                return;
            }
            this.auth();
        },
        // token检验
        auth() {
            this.$axios.get(`/user/auth`).then(res => {
                const { data } = res;
                if (data.code === 200) {
                    // 存储用户信息
                    setUserInfo(data.data);
                    this.userInfo = data.data;
                    this.queryProductInfo();
                }
                this.loginStatus = data.code === 200;
            }).catch(error => {
                console.log("token检验异常：", error);
            });
        },
    }
};
</script>
<style scoped lang="scss">
.avatar {
    border: 3px solid rgb(51, 51, 51);
    width: 30px;
    width: 30px;
    border-radius: 50%;
}

.avatar:hover {
    border: 3px solid rgb(216, 206, 25);
}

.word-search {
    display: flex;
    justify-content: center;

    .item {
        max-width: 210px;
        background-color: rgb(244, 244, 244);
        border-radius: 20px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        box-sizing: border-box;
        border: 1px solid rgb(245, 245, 245);

        input:focus {
            width: 110px;
        }

        input {
            border: none;
            transition: all 0.6s;
            width: 80px;
            margin: 0 10px;
            background-color: rgb(244, 244, 244);
            outline: none;
            font-size: 14px;
        }

        i {
            padding: 6px 12px;
            border-radius: 5px;
            cursor: pointer;
            border-top-right-radius: 20px;
            border-bottom-right-radius: 20px;
            background-color: rgb(244, 244, 244);
        }

        i:hover {
            background-color: rgb(241, 241, 241);
        }
    }

}

.container {
    background-color: rgb(51, 51, 51);
}

.info {
    padding: 10px 200px;
    display: flex;

    img {
        padding: 6px;
        box-sizing: border-box;
        border: 3px solid rgb(255, 255, 255);
    }

    .title1 {
        font-size: 26px;
        color: rgb(255, 255, 255);
        gap: 12px;

        .poin {
            display: inline-block;
            padding: 2px 6px;
            margin-inline: 4px;
            box-sizing: border-box;
            border-radius: 20px;
            cursor: pointer;
            font-size: 10px;
            color: rgb(255, 255, 255);
            background-color: rgb(197, 153, 57);
        }
    }

    .save,
    .date {
        margin: 10px 0;
        font-size: 12px;
        color: rgb(153, 150, 141);
    }

}

.top {

    height: 80px;
    padding: 0 200px;
    display: flex;
    justify-content: space-between;
    align-items: center;

    .nav {
        padding: 20px 0;
        display: flex;
        justify-content: left;
        align-items: center;
        gap: 20px;

        .route {
            display: flex;
            justify-content: left;
            align-items: center;
            gap: 30px;


            span {
                font-size: 14px;
                color: rgb(143, 143, 143);
                cursor: pointer;
            }

            span:hover {
                color: rgb(255, 255, 255);
            }
        }

    }
}
</style>
```

<h1 id="pMGDx">数据库</h1>
新增“上一次登录时间”字段。

![](https://cdn.nlark.com/yuque/0/2024/png/32649796/1734839076125-94ebc5f4-fff5-4bda-9ec7-62f714ac86ea.png)

<h1 id="Gzsqb">后端</h1>
<h2 id="UAQPR">实体类</h2>
替换pojo/entity包下的User.java用户实体类，新增了**<u>“上一次登录时间”</u>**字段。

```java
package cn.kmbeast.pojo.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

/**
 * 用户实体
 */
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class User {

    /**
     * 用户编号
     */
    private Integer id;

    /**
     * 用户账号
     */
    private String userAccount;

    /**
     * 用户昵称
     */
    private String userName;

    /**
     * 用户密码
     */
    private String userPwd;


    /**
     * 用户头像
     */
    private String userAvatar;

    /**
     * 用户邮箱
     */
    private String userEmail;

    /**
     * 用户角色
     */
    private Integer userRole;

    /**
     * 可登录状态(0:可用；1：不可用)
     */
    private Boolean isLogin;

    /**
     * 禁言状态(0:可用；1：不可用)
     */
    private Boolean isWord;

    /**
     * 上一次登录时间
     */
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime lastLoginTime;

    /**
     * 用户注册时间
     */
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime createTime;
}
```

替换pojo/vo包下的UserVO.java用户实体出参类，新增了**<u>“上一次登录时间”</u>**字段。

```java
package cn.kmbeast.pojo.vo;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

/**
 * 用户VO
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class UserVO {
    /**
     * 用户ID
     */
    private Integer id;

    /**
     * 用户账号
     */
    private String userAccount;

    /**
     * 用户昵称
     */
    private String userName;

    /**
     * 用户头像
     */
    private String userAvatar;

    /**
     * 用户邮箱
     */
    private String userEmail;

    /**
     * 用户角色
     */
    private Integer userRole;

    /**
     * 登录状态
     */
    private Boolean isLogin;

    /**
     * 禁言状态
     */
    private Boolean isWord;

    /**
     * 上一次登录时间
     */
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime lastLoginTime;

    /**
     * 注册时间
     */
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime createTime;

}
```

<h2 id="wDp2z">拦截器</h2>
拦截器中，添加放行配置。

```java
package cn.kmbeast.Interceptor;

import cn.kmbeast.context.LocalThreadHolder;
import cn.kmbeast.pojo.api.ApiResult;
import cn.kmbeast.pojo.api.Result;
import cn.kmbeast.utils.JwtUtil;
import com.alibaba.fastjson2.JSONObject;
import io.jsonwebtoken.Claims;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.Writer;

/**
 * token拦截器，做请求拦截
 * 思路：用户登录成功后，会得到后端生成的 token，前端会将token存储于本地
 * 随后的接口请求，都会在协议头带上token
 * 所有请求执行之前，都会被该拦截器拦截：token校验通过则正常放行请求，否则直接返回
 *
 * @author 【B站：程序员辰星】
 */
public class JwtInterceptor implements HandlerInterceptor {

    /**
     * 前置拦截
     *
     * @param request  current HTTP request
     * @param response current HTTP response
     * @param handler  chosen handler to execute, for type and/or instance evaluation
     * @return boolean true ： 放行；false拦截
     * @throws Exception 异常
     */
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        String requestMethod = request.getMethod();
        // 放行预检请求
        if ("OPTIONS".equals(requestMethod)) {
            return true;
        }
        String requestURI = request.getRequestURI();
        // 登录及错误等请求不做拦截
        if (requestURI.contains("/login") ||
            requestURI.contains("/error") ||
            requestURI.contains("/file") ||
            requestURI.contains("/query") && !requestURI.contains("/queryUser")
            && !requestURI.contains("/queryOrdersList")
            && !requestURI.contains("/queryProductInfo") ||
            requestURI.contains("/register")) {
            return true;
        }
        String token = request.getHeader("token");
        Claims claims = JwtUtil.fromToken(token);
        // 解析不成功，直接退回！访问后续资源的可能性都没有！
        if (claims == null) {
            Result<String> error = ApiResult.error("身份认证异常，请先登录");
            response.setContentType("application/json;charset=UTF-8");
            Writer stream = response.getWriter();
            // 将失败信息输出
            stream.write(JSONObject.toJSONString(error));
            stream.flush();
            stream.close();
            return false;
        }
        Integer userId = claims.get("id", Integer.class);
        Integer roleId = claims.get("role", Integer.class);
        // 将解析出来的用户ID、用户角色放置于LocalThread中，当前线程可用
        LocalThreadHolder.setUserId(userId, roleId);
        return true;
    }
}
```

<h2 id="OR7Gp">控制器层（controller）</h2>
使用下列的代码替换ProductController.java接口类

```java
package cn.kmbeast.controller;

import cn.kmbeast.aop.Log;
import cn.kmbeast.aop.Pager;
import cn.kmbeast.context.LocalThreadHolder;
import cn.kmbeast.pojo.api.Result;
import cn.kmbeast.pojo.dto.query.extend.ProductQueryDto;
import cn.kmbeast.pojo.dto.update.OrdersDTO;
import cn.kmbeast.pojo.entity.Product;
import cn.kmbeast.pojo.vo.ChartVO;
import cn.kmbeast.pojo.vo.ProductVO;
import cn.kmbeast.service.ProductService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

/**
 * 商品控制器
 */
@RestController
@RequestMapping("/product")
public class ProductController {

    @Resource
    private ProductService productService;

    /**
     * 商品下单
     *
     * @param ordersDTO 参数
     * @return Result<String> 响应结果
     */
    @Log(detail = "商品下单")
    @PostMapping(value = "/buyProduct")
    @ResponseBody
    public Result<String> buyProduct(@RequestBody OrdersDTO ordersDTO) {
        return productService.buyProduct(ordersDTO);
    }


    /**
     * 新增
     *
     * @param product 参数
     * @return Result<String> 响应结果
     */
    @Log(detail = "商品上架")
    @PostMapping(value = "/save")
    @ResponseBody
    public Result<String> save(@RequestBody Product product) {
        return productService.save(product);
    }

    /**
     * 修改
     *
     * @param product 参数
     * @return Result<String> 响应结果
     */
    @Log(detail = "商品修改")
    @PutMapping(value = "/update")
    @ResponseBody
    public Result<String> update(@RequestBody Product product) {
        return productService.update(product);
    }

    /**
     * 批量删除
     */
    @PostMapping(value = "/batchDelete")
    @ResponseBody
    public Result<String> batchDelete(@RequestBody List<Integer> ids) {
        return productService.batchDelete(ids);
    }

    /**
     * 查询
     *
     * @param productQueryDto 查询参数
     * @return Result<List < ProductVO>> 响应结果
     */
    @Pager
    @PostMapping(value = "/query")
    @ResponseBody
    public Result<List<ProductVO>> query(@RequestBody ProductQueryDto productQueryDto) {
        return productService.query(productQueryDto);
    }

    /**
     * 商品下单
     *
     * @param ordersId 订单ID
     * @return Result<String> 响应结果
     */
    @PostMapping(value = "/placeAnOrder/{ordersId}")
    @ResponseBody
    public Result<String> placeAnOrder(@PathVariable Integer ordersId) {
        return productService.placeAnOrder(ordersId);
    }

    /**
     * 申请退款
     *
     * @param ordersId 订单ID
     * @return Result<String> 响应结果
     */
    @Log(detail = "商品申请退款")
    @PostMapping(value = "/refund/{ordersId}")
    @ResponseBody
    public Result<String> refund(@PathVariable Integer ordersId) {
        return productService.refund(ordersId);
    }

    /**
     * 查询用户商品指标情况
     *
     * @param productQueryDto 查询参数
     * @return Result<List < ChartVO>> 响应结果
     */
    @PostMapping(value = "/queryProductInfo")
    @ResponseBody
    public Result<List<ChartVO>> queryProductInfo(@RequestBody ProductQueryDto productQueryDto) {
        productQueryDto.setUserId(LocalThreadHolder.getUserId());
        return productService.queryProductInfo(productQueryDto);
    }

    /**
     * 查询用户商品列表
     *
     * @param productQueryDto 查询参数
     * @return Result<List < ProductVO>> 响应结果
     */
    @PostMapping(value = "/queryUser")
    @ResponseBody
    public Result<List<ProductVO>> queryUser(@RequestBody ProductQueryDto productQueryDto) {
        productQueryDto.setUserId(LocalThreadHolder.getUserId());
        return productService.query(productQueryDto);
    }

}
```

<h2 id="M4Rfc">业务逻辑层（service）</h2>
替换ProductService.java业务逻辑接口

```java
package cn.kmbeast.service;

import cn.kmbeast.pojo.api.Result;
import cn.kmbeast.pojo.dto.query.extend.ProductQueryDto;
import cn.kmbeast.pojo.dto.update.OrdersDTO;
import cn.kmbeast.pojo.entity.Orders;
import cn.kmbeast.pojo.entity.Product;
import cn.kmbeast.pojo.vo.ChartVO;
import cn.kmbeast.pojo.vo.ProductVO;

import java.util.List;

/**
 * 商品的业务逻辑接口
 */
public interface ProductService {

    Result<String> save(Product product);

    Result<String> update(Product product);

    Result<String> batchDelete(List<Integer> ids);

    Result<List<ProductVO>> query(ProductQueryDto productQueryDto);

    Result<String> buyProduct(OrdersDTO ordersDTO);

    Result<String> placeAnOrder(Integer ordersId);

    Result<String> refund(Integer ordersId);

    Result<List<ChartVO>> queryProductInfo(ProductQueryDto productQueryDto);

}
```

替换ProductServiceImpl.java业务逻辑接口实现类

```java
package cn.kmbeast.service.impl;

import cn.kmbeast.context.LocalThreadHolder;
import cn.kmbeast.mapper.InteractionMapper;
import cn.kmbeast.mapper.OrdersMapper;
import cn.kmbeast.mapper.ProductMapper;
import cn.kmbeast.pojo.api.ApiResult;
import cn.kmbeast.pojo.api.Result;
import cn.kmbeast.pojo.dto.query.extend.ProductQueryDto;
import cn.kmbeast.pojo.dto.update.OrdersDTO;
import cn.kmbeast.pojo.em.InteractionEnum;
import cn.kmbeast.pojo.entity.Interaction;
import cn.kmbeast.pojo.entity.Orders;
import cn.kmbeast.pojo.entity.Product;
import cn.kmbeast.pojo.vo.ChartVO;
import cn.kmbeast.pojo.vo.ProductVO;
import cn.kmbeast.service.ProductService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

/**
 * 商品类别业务逻辑接口实现类
 */
@Service
public class ProductServiceImpl implements ProductService {

    @Resource
    private ProductMapper productMapper;
    @Resource
    private OrdersMapper ordersMapper;
    @Resource
    private InteractionMapper interactionMapper;

    /**
     * 新增
     *
     * @param product 参数
     * @return Result<String> 后台通用返回封装类
     */
    @Override
    public Result<String> save(Product product) {
        product.setUserId(LocalThreadHolder.getUserId());
        product.setCreateTime(LocalDateTime.now());
        productMapper.save(product);
        return ApiResult.success("商品新增成功");
    }

    /**
     * 修改
     *
     * @param product 参数
     * @return Result<String> 后台通用返回封装类
     */
    @Override
    public Result<String> update(Product product) {
        productMapper.update(product);
        return ApiResult.success("商品修改成功");
    }

    /**
     * 删除
     *
     * @param ids 待删除ID集合
     * @return Result<String> 后台通用返回封装类
     */
    @Override
    public Result<String> batchDelete(List<Integer> ids) {
        productMapper.batchDelete(ids);
        return ApiResult.success("商品删除成功");
    }

    /**
     * 查询
     *
     * @param productQueryDto 查询参数
     * @return Result<List < ProductVO>> 后台通用返回封装类
     */
    @Override
    public Result<List<ProductVO>> query(ProductQueryDto productQueryDto) {
        int totalCount = productMapper.queryCount(productQueryDto);
        List<ProductVO> productVOList = productMapper.query(productQueryDto);
        return ApiResult.success(productVOList, totalCount);
    }

    /**
     * 商品下单
     *
     * @param ordersDTO 订单
     * @return Result<String>
     */
    @Override
    public Result<String> buyProduct(OrdersDTO ordersDTO) {
        if (ordersDTO.getProductId() == null) {
            return ApiResult.error("商品ID不为空");
        }
        ProductQueryDto productQueryDto = new ProductQueryDto();
        productQueryDto.setId(ordersDTO.getProductId());
        List<ProductVO> productVOS = productMapper.query(productQueryDto);
        if (productVOS.isEmpty()) {
            return ApiResult.error("商品信息异常");
        }
            // 有且仅有一条商品信息
            ProductVO productVO = productVOS.get(0);
        // 判断库存情况
        if (productVO.getInventory() <= 0
                || (productVO.getInventory() - ordersDTO.getBuyNumber()) < 0) {
            return ApiResult.error("商品库存不足");
        }
        createOrders(ordersDTO, productVO);
        ordersMapper.save(ordersDTO);
        // 扣库存
        Product product = new Product();
        product.setId(productVO.getId());
        product.setInventory(productVO.getInventory() - ordersDTO.getBuyNumber());
        productMapper.update(product);
        return ApiResult.success("下单成功");
    }

    /**
     * 设置订单所需参数
     *
     * @param orders    订单
     * @param productVO 商品信息
     */
    private void createOrders(Orders orders, ProductVO productVO) {
        orders.setCode(createOrdersCode());
        orders.setUserId(LocalThreadHolder.getUserId());
        orders.setTradeStatus(false); // 初始时，未交易成功
        orders.setBuyPrice(productVO.getPrice());
        orders.setCreateTime(LocalDateTime.now());
    }

    /**
     * 生成订单号
     *
     * @return String
     */
    private String createOrdersCode() {
        // UUID
        //String ordersCode = UUID.randomUUID().toString().toLowerCase();
        // 时间戳
        long timeMillis = System.currentTimeMillis();
        return String.valueOf(timeMillis);
    }

    /**
     * 商品下单
     *
     * @param ordersId 订单ID
     * @return Result<String> 通用返回封装类
     */
    @Override
    public Result<String> placeAnOrder(Integer ordersId) {
        Orders orders = new Orders();
        orders.setId(ordersId);
        orders.setTradeStatus(true);
        orders.setTradeTime(LocalDateTime.now());
        ordersMapper.update(orders);
        return ApiResult.success("下单成功");
    }

    /**
     * 申请退款
     *
     * @param ordersId 订单ID
     * @return Result<String> 响应结果
     */
    @Override
    public Result<String> refund(Integer ordersId) {
        Orders orders = new Orders();
        orders.setId(ordersId);
        orders.setRefundStatus(true);
        ordersMapper.update(orders);
        return ApiResult.success("申请退款成功，请等待卖家审核");
    }

    /**
     * 查询用户商品指标情况
     *
     * @param productQueryDto 查询参数
     * @return Result<List < ChartVO>> 响应结果
     */
    @Override
    public Result<List<ChartVO>> queryProductInfo(ProductQueryDto productQueryDto) {
        List<Integer> productIds = productMapper.queryProductIds(productQueryDto.getUserId());
        List<Interaction> interactionList = interactionMapper.queryByProductIds(productIds);
        // 浏览、收藏、想要
        long viewCount = getProductCount(interactionList, InteractionEnum.VIEW.getType());
        long saveCount = getProductCount(interactionList, InteractionEnum.SAVE.getType());
        long loveCount = getProductCount(interactionList, InteractionEnum.LOVE.getType());
        List<ChartVO> chartVOList = new ArrayList<>();
        ChartVO chartVOView = new ChartVO("商品被浏览",(int)viewCount);
        ChartVO chartVOSave = new ChartVO("商品被收藏",(int)saveCount);
        ChartVO chartVOLove = new ChartVO("商品被想要",(int)loveCount);
        chartVOList.add(chartVOView);
        chartVOList.add(chartVOSave);
        chartVOList.add(chartVOLove);
        return ApiResult.success(chartVOList);
    }

    /**
     * 过滤指定的商品指标数据
     *
     * @param interactionList 互动数据源
     * @param type            互动类型
     * @return long
     */
    private long getProductCount(List<Interaction> interactionList, Integer type) {
        return interactionList.stream()
                .filter(interaction -> Objects.equals(type, interaction.getType()))
                .count();
    }
}
```

使用下列的代码，替换UserServiceImpl.java

```java
package cn.kmbeast.service.impl;

import cn.kmbeast.context.LocalThreadHolder;
import cn.kmbeast.mapper.UserMapper;
import cn.kmbeast.pojo.api.ApiResult;
import cn.kmbeast.pojo.api.PageResult;
import cn.kmbeast.pojo.api.Result;
import cn.kmbeast.pojo.dto.query.extend.UserQueryDto;
import cn.kmbeast.pojo.dto.update.UserLoginDTO;
import cn.kmbeast.pojo.dto.update.UserRegisterDTO;
import cn.kmbeast.pojo.dto.update.UserUpdateDTO;
import cn.kmbeast.pojo.em.LoginStatusEnum;
import cn.kmbeast.pojo.em.RoleEnum;
import cn.kmbeast.pojo.em.WordStatusEnum;
import cn.kmbeast.pojo.entity.User;
import cn.kmbeast.pojo.vo.UserVO;
import cn.kmbeast.service.UserService;
import cn.kmbeast.utils.JwtUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

/**
 * 用户服务实现类
 */
@Service
@Slf4j
public class UserServiceImpl implements UserService {

    @Resource
    private UserMapper userMapper;

    /**
     * 用户注册
     *
     * @param userRegisterDTO 注册入参
     * @return Result<String> 响应结果
     */
    @Override
    public Result<String> register(UserRegisterDTO userRegisterDTO) {
        User entity = userMapper.getByActive(
            User.builder().userAccount(userRegisterDTO.getUserAccount()).build()
        );
        if (Objects.nonNull(entity)) {
            return ApiResult.error("账号不可用");
        }
        User saveEntity = User.builder()
        .userRole(RoleEnum.USER.getRole())
        .userName(userRegisterDTO.getUserName())
        .userAccount(userRegisterDTO.getUserAccount())
        .userAvatar(userRegisterDTO.getUserAvatar())
        .userPwd(userRegisterDTO.getUserPwd())
        .userEmail(userRegisterDTO.getUserEmail())
        .createTime(LocalDateTime.now())
        .isLogin(LoginStatusEnum.USE.getFlag())
        .isWord(WordStatusEnum.USE.getFlag()).build();
        userMapper.insert(saveEntity);
        return ApiResult.success("注册成功");
    }

    /**
     * 用户登录
     *
     * @param userLoginDTO 登录入参
     * @return Result<String> 响应结果
     */
    @Override
    public Result<Object> login(UserLoginDTO userLoginDTO) {
        User user = userMapper.getByActive(
            User.builder().userAccount(userLoginDTO.getUserAccount()).build()
        );
        if (!Objects.nonNull(user)) {
            return ApiResult.error("账号不存在");
        }
        if (!Objects.equals(userLoginDTO.getUserPwd(), user.getUserPwd())) {
            return ApiResult.error("密码错误");
        }
        if (user.getIsLogin()) {
            return ApiResult.error("登录状态异常");
        }
        String token = JwtUtil.toToken(user.getId(), user.getUserRole());
        Map<String, Object> map = new HashMap<>();
        map.put("token", token);
        map.put("role", user.getUserRole());
        // 设置上一次登录时间
        User userEntity = new User();
        userEntity.setId(user.getId());
        userEntity.setLastLoginTime(LocalDateTime.now());
        userMapper.update(userEntity);
        return ApiResult.success("登录成功", map);
    }

    /**
     * 令牌检验 -- 认证成功返回用户信息
     *
     * @return Result<UserVO>
     */
    @Override
    public Result<UserVO> auth() {
        Integer userId = LocalThreadHolder.getUserId();
        User queryEntity = User.builder().id(userId).build();
        User user = userMapper.getByActive(queryEntity);
        UserVO userVO = new UserVO();
        BeanUtils.copyProperties(user, userVO);
        return ApiResult.success(userVO);
    }

    /**
     * 分页查询用户数据
     *
     * @param userQueryDto 分页参数
     * @return Result<List < User>> 响应结果
     */
    @Override
    public Result<List<User>> query(UserQueryDto userQueryDto) {
        List<User> users = userMapper.query(userQueryDto);
        Integer count = userMapper.queryCount(userQueryDto);
        return PageResult.success(users, count);
    }

    /**
     * 用户信息修改
     *
     * @param userUpdateDTO 修改信息入参
     * @return Result<String> 响应结果
     */
    @Override
    public Result<String> update(UserUpdateDTO userUpdateDTO) {
        User updateEntity = User.builder().id(LocalThreadHolder.getUserId()).build();
        BeanUtils.copyProperties(userUpdateDTO, updateEntity);
        userMapper.update(updateEntity);
        return ApiResult.success();
    }


    /**
     * 批量删除用户信息
     */
    @Override
    public Result<String> batchDelete(List<Integer> ids) {
        userMapper.batchDelete(ids);
        return ApiResult.success();
    }

    /**
     * 用户信息修改密码
     *
     * @param map 修改信息入参
     * @return Result<String> 响应结果
     */
    @Override
    public Result<String> updatePwd(Map<String, String> map) {
        String oldPwd = map.get("oldPwd");
        String newPwd = map.get("newPwd");
        String againPwd = map.get("againPwd");
        if (Objects.isNull(oldPwd)) {
            return ApiResult.error("原始密码输入不能为空");
        }
        if (Objects.isNull(newPwd)) {
            return ApiResult.error("请输入新密码");
        }
        if (Objects.isNull(againPwd)) {
            return ApiResult.error("请补充确认密码");
        }
        if (!newPwd.equals(againPwd)) {
            return ApiResult.error("前后密码输入不一致");
        }
        User user = userMapper.getByActive(
                User.builder().id(LocalThreadHolder.getUserId()).build()
        );
        if (!user.getUserPwd().equals(oldPwd)) {
            return ApiResult.error("原始密码验证失败");
        }
        user.setUserPwd(newPwd);
        userMapper.update(user);
        return ApiResult.success();
    }

    /**
     * 通过ID查询用户信息
     *
     * @param id 用户ID
     */
    @Override
    public Result<UserVO> getById(Integer id) {
        User user = userMapper.getByActive(User.builder().id(id).build());
        UserVO userVO = new UserVO();
        BeanUtils.copyProperties(user, userVO);
        return ApiResult.success(userVO);
    }

    /**
     * 后台新增用户
     *
     * @param userRegisterDTO 注册入参
     * @return Result<String> 响应结果
     */
    @Override
    public Result<String> insert(UserRegisterDTO userRegisterDTO) {
        return register(userRegisterDTO);
    }

    /**
     * 后台用户信息修改
     *
     * @param user 信息实体
     * @return Result<String> 响应结果
     */
    @Override
    public Result<String> backUpdate(User user) {
        userMapper.update(user);
        return ApiResult.success();
    }

}
```

<h2 id="sW5it">持久化层（mapper）</h2>
替换InteractionMapper.java持久化接口

```java
package cn.kmbeast.mapper;

import cn.kmbeast.pojo.dto.query.extend.InteractionQueryDto;
import cn.kmbeast.pojo.entity.Interaction;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 互动信息持久化接口
 */
public interface InteractionMapper {

    /**
     * 新增
     *
     * @param interaction 实体信息
     * @return int 受影响行数
     */
    int save(Interaction interaction);

    /**
     * 分页查询互动行为信息
     *
     * @param interactionQueryDto 分页查询参数
     * @return List<Interaction>
     */
    List<Interaction> query(InteractionQueryDto interactionQueryDto);

    /**
     * 查询商品指标数据
     *
     * @param ids 商品ID列表
     * @return List<Interaction>
     */
    List<Interaction> queryByProductIds(@Param(value = "ids")List<Integer> ids);

    /**
     * 查询满足分页查询的记录总数
     *
     * @param interactionQueryDto 分页查询参数
     * @return int 数据总数
     */
    int queryCount(InteractionQueryDto interactionQueryDto);

    /**
     * 批量删除用户信息
     *
     * @param ids 用户ID集合
     */
    void batchDelete(@Param(value = "ids") List<Integer> ids);

}
```

使用下列完整的代码替换resources/mapper包下的InteractionMapper.xml

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="cn.kmbeast.mapper.InteractionMapper">

  <insert id="save">
    INSERT INTO interaction (user_id,product_id,type,create_time)
    VALUES (#{userId},#{productId},#{type},#{createTime})
  </insert>

  <delete id="batchDelete" parameterType="list">
    DELETE FROM interaction WHERE id IN
    <foreach collection="ids" item="id" open="(" separator="," close=")">
      #{id}
    </foreach>
  </delete>

  <select id="query" resultMap="BaseResultMap">

    SELECT i.*,
    u.user_name,
    u.user_account,
    p.name AS product_title
    FROM interaction i
    LEFT JOIN user u ON u.id = i.user_id
    LEFT JOIN product p ON p.id = i.product_id
    <where>
      <if test="id != null">
        AND i.id = #{id}
      </if>
      <if test="userId != null">
        AND i.user_id = #{userId}
      </if>
      <if test="productId != null">
        AND i.product_id = #{productId}
      </if>
      <if test="type != null">
        AND i.type = #{type}
      </if>
      <if test="startTime != null and endTime != null">
        AND i.create_time BETWEEN #{startTime} AND #{endTime}
      </if>
    </where>
    ORDER BY i.id DESC
    <if test="current != null and size != null">
      LIMIT #{current},#{size}
    </if>
  </select>

  <!--满足分页条件的数据总项-->
  <select id="queryCount" resultType="integer">

    SELECT COUNT(*)
    FROM interaction i
    <where>
      <if test="id != null">
        AND i.id = #{id}
      </if>
      <if test="userId != null">
        AND i.user_id = #{userId}
      </if>
      <if test="productId != null">
        AND i.product_id = #{productId}
      </if>
      <if test="type != null">
        AND i.type = #{type}
      </if>
      <if test="startTime != null and endTime != null">
        AND i.create_time BETWEEN #{startTime} AND #{endTime}
      </if>
    </where>

  </select>

  <select id="queryByProductIds" resultMap="BaseResultMap">
    SELECT i.*
    FROM interaction i WHERE i.product_id IN
    <foreach collection="ids" item="id" open="(" separator="," close=")">
      #{id}
    </foreach>
  </select>

  <!-- 通用查询映射结果 -->
  <resultMap id="BaseResultMap" type="cn.kmbeast.pojo.vo.InteractionVO">
    <id column="id" property="id"/>
    <result column="user_id" property="userId"/>
    <result column="product_id" property="productId"/>
    <result column="user_name" property="userName"/>
    <result column="user_account" property="userAccount"/>
    <result column="product_title" property="productTitle"/>
        <result column="type" property="type"/>
        <result column="create_time" property="createTime"/>
    </resultMap>


</mapper>
```

使用下列完整的代码替换resources/mapper包下的UserMapper.xml

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="cn.kmbeast.mapper.UserMapper">
  <insert id="insert" parameterType="cn.kmbeast.pojo.entity.User">
    INSERT INTO user (user_account,
    user_name,
    user_pwd,
    user_avatar,
    user_email,
    user_role,
    is_login,
    is_word,
    last_login_time,
    create_time)
    VALUES (#{userAccount},
    #{userName},
    #{userPwd},
    #{userAvatar},
    #{userEmail},
    #{userRole},
    #{isLogin},
    #{isWord},
    #{lastLoginTime},
    #{createTime})
  </insert>
  <update id="update" parameterType="cn.kmbeast.pojo.entity.User">
    UPDATE user
    <set>
      <if test="userAccount != null">
        user_account = #{userAccount},
      </if>
      <if test="userName != null">
        user_name = #{userName},
      </if>
      <if test="userPwd != null">
        user_pwd = #{userPwd},
      </if>
      <if test="userAvatar != null">
        user_avatar = #{userAvatar},
      </if>
      <if test="userEmail != null">
        user_email = #{userEmail},
      </if>
      <if test="isLogin != null">
        is_login = #{isLogin},
      </if>
      <if test="isWord != null">
        is_word = #{isWord},
      </if>
      <if test="userRole != null">
        user_role = #{userRole},
      </if>
      <if test="lastLoginTime != null">
        last_login_time = #{lastLoginTime},
      </if>
    </set>
    WHERE id = #{id}

  </update>

  <delete id="batchDelete" parameterType="list">
    DELETE FROM user WHERE id IN
    <foreach collection="ids" item="id" open="(" separator="," close=")">
      #{id}
    </foreach>
  </delete>

  <select id="getByActive" resultMap="BaseResultMap">
    SELECT u.*
    FROM user u
    <where>
      1 = 1
      <if test="id != null">
        AND u.id = #{id}
      </if>
      <if test="userName != null and userName != ''">
        AND u.user_name = #{userName}
      </if>
      <if test="userAccount != null and userAccount != ''">
        AND u.user_account = #{userAccount}
      </if>
    </where>

  </select>

  <!--分页查询用户信息-->
  <select id="query" resultMap="BaseResultMap">

    SELECT u.*
    FROM user u
    <where>
      <if test="userAccount != null and userAccount != ''">
        AND u.user_account LIKE concat('%',#{userAccount},'%')
      </if>
            <if test="userName != null and userName != ''">
                AND u.user_name LIKE concat('%',#{userName},'%')
            </if>
            <if test="userEmail != null and userEmail != ''">
                AND u.user_email LIKE concat('%',#{userEmail},'%')
            </if>
            <if test="role != null">
                AND u.role = #{role}
            </if>
            <if test="isLogin != null">
                AND u.is_login = #{isLogin}
            </if>
            <if test="isWord != null">
                AND u.is_word = #{isWord}
            </if>
            <if test="startTime != null and endTime != null">
                AND u.create_time BETWEEN #{startTime} AND #{endTime}
            </if>
        </where>
        ORDER BY u.create_time DESC
        <if test="current != null and size != null">
            LIMIT #{current},#{size}
        </if>
    </select>

    <!--满足分页条件的数据总项-->
    <select id="queryCount" resultType="integer">

        SELECT COUNT(*)
        FROM user u
        <where>
            <if test="userAccount != null and userAccount != ''">
                AND u.user_account LIKE concat('%',#{userAccount},'%')
            </if>
            <if test="userName != null and userName != ''">
                AND u.user_name LIKE concat('%',#{userName},'%')
            </if>
            <if test="userEmail != null and userEmail != ''">
                AND u.user_email LIKE concat('%',#{userEmail},'%')
            </if>
            <if test="role != null">
                AND u.role = #{role}
            </if>
            <if test="isLogin != null">
                AND u.is_login = #{isLogin}
            </if>
            <if test="isWord != null">
                AND u.is_word = #{isWord}
            </if>
            <if test="startTime != null and endTime != null">
                AND u.create_time BETWEEN #{startTime} AND #{endTime}
            </if>
        </where>

    </select>

    <!-- 通用查询映射结果 -->
    <resultMap id="BaseResultMap" type="cn.kmbeast.pojo.entity.User">
        <id column="id" property="id"/>
        <result column="user_account" property="userAccount"/>
        <result column="user_name" property="userName"/>
        <result column="user_pwd" property="userPwd"/>
        <result column="user_avatar" property="userAvatar"/>
        <result column="user_email" property="userEmail"/>
        <result column="user_role" property="userRole"/>
        <result column="is_login" property="isLogin"/>
        <result column="is_word" property="isWord"/>
        <result column="last_login_time" property="lastLoginTime"/>
        <result column="create_time" property="createTime"/>
    </resultMap>


</mapper>
```

