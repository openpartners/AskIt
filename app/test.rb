/** @type {SyncHook<[CompilationAssets]>} */
555:    const afterProcessAssetsHook = new SyncHook(["assets"]);
556
557     /**
...
  563      * @returns {FakeHook<Pick<AsyncSeriesHook<T>, "tap" | "tapAsync" | "tapPromise" | "name">>} fake hook which redirects
564      */
565:    const createProcessAssetsHook = (name, stage, getArgs, code) => {
  566       if (!this._backCompat && code) return undefined;
  567       const errorMessage =
  568:        reason => `Can't automatically convert plugin using Compilation.hooks.${name} to Compilation.hooks.processAssets because ${reason}.
  569: BREAKING CHANGE: Asset processing hooks in Compilation has been merged into a single Compilation.hooks.processAssets hook.`;
  570       const getOptions = options => {
    571         if (typeof options === "string") options = { name: options };
    ...
    584           /** @type {AsyncSeriesHook<T>["tap"]} */
    585           tap: (options, fn) => {
      586:            processAssetsHook.tap(getOptions(options), () => fn(...getArgs()));
    587           },
    588           /** @type {AsyncSeriesHook<T>["tapAsync"]} */
    589           tapAsync: (options, fn) => {
      590:            processAssetsHook.tapAsync(
        591               getOptions(options),
        592:              (assets, callback) =>
        593                 /** @type {any} */ (fn)(...getArgs(), callback)
      594             );
      ...
      596           /** @type {AsyncSeriesHook<T>["tapPromise"]} */
      597           tapPromise: (options, fn) => {
        598:            processAssetsHook.tapPromise(getOptions(options), () =>
                                                     599               fn(...getArgs())
                                                     600             );
      601           }
    602         },
    603:        `${name} is deprecated (use Compilation.hooks.processAssets instead and use one of Compilation.PROCESS_ASSETS_STAGE_* as stage option)`,
    604         code
    605       );
    ...
    770
    771       /** @type {SyncHook<[]>} */
    772:      beforeModuleAssets: new SyncHook([]),
    773       /** @type {SyncBailHook<[], boolean>} */
    774:      shouldGenerateChunkAssets: new SyncBailHook([]),
    775       /** @type {SyncHook<[]>} */
    776:      beforeChunkAssets: new SyncHook([]),
    777       // TODO webpack 6 remove
    778       /** @deprecated */
    779:      additionalChunkAssets: createProcessAssetsHook(
      780:        "additionalChunkAssets",
      781:        Compilation.PROCESS_ASSETS_STAGE_ADDITIONAL,
      782         () => [this.chunks],
      783:        "DEP_WEBPACK_COMPILATION_ADDITIONAL_CHUNK_ASSETS"
    784       ),
    785
    786       // TODO webpack 6 deprecate
    787       /** @deprecated */
    788:      additionalAssets: createProcessAssetsHook(
      789:        "additionalAssets",
      790:        Compilation.PROCESS_ASSETS_STAGE_ADDITIONAL,
      791         () => []
    792       ),
    793       // TODO webpack 6 remove
    794       /** @deprecated */
    795:      optimizeChunkAssets: createProcessAssetsHook(
      796:        "optimizeChunkAssets",
      797:        Compilation.PROCESS_ASSETS_STAGE_OPTIMIZE,
      798         () => [this.chunks],
      799:        "DEP_WEBPACK_COMPILATION_OPTIMIZE_CHUNK_ASSETS"
    800       ),
    801       // TODO webpack 6 remove
    802       /** @deprecated */
    803:      afterOptimizeChunkAssets: createProcessAssetsHook(
      804:        "afterOptimizeChunkAssets",
      805:        Compilation.PROCESS_ASSETS_STAGE_OPTIMIZE + 1,
      806         () => [this.chunks],
      807:        "DEP_WEBPACK_COMPILATION_AFTER_OPTIMIZE_CHUNK_ASSETS"
    808       ),
    809       // TODO webpack 6 deprecate
    810       /** @deprecated */
    811:      optimizeAssets: processAssetsHook,
    812       // TODO webpack 6 deprecate
    813       /** @deprecated */
    814:      afterOptimizeAssets: afterProcessAssetsHook,
