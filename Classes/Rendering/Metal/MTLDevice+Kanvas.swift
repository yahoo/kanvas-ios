//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at https://mozilla.org/MPL/2.0/.
//

import MetalKit

// This is a workaround to load metal shaders from Kanvas bundle.
// 1. Read .metal files from Kanvas.bundle/MetalShaders/ directory
// 2. Concatinate all source files as a string then compile it at runtime by using MTLDevice::makeLibrary(source:options:)
extension MTLDevice {
    public func makeKanvasDefaultLibrary() -> MTLLibrary? {
        let url = Bundle.module.url(forResource: "shaders", withExtension: "metal")!
        
        var source = ""
        
        do {
            source += try String(String(contentsOf: url, encoding: .utf8))
        }
        catch {
            print("failed to read")
        }
        
        do {
            let library = try makeLibrary(source: source, options: nil)
            return library
        }
        catch {
            print("\(error)")
            return nil
        }
    }
}
