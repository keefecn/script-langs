#! /bin/bash
# @requiremnet: node-14+
# @see: Docker镜像优化：从1.16GB到22.4MB！  https://zhuanlan.zhihu.com/p/427116788
npx create-react-app app --template typescript
cd app
# run: npm start (devel),  npm run build (product)
npm start
# or
npm run build

# access: http://localhost:3000
